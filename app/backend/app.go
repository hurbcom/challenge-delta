package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/go-redis/redis"
	_ "github.com/go-sql-driver/mysql"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

type Response struct {
	RequestUUID string `json:"request_uuid"`
	Time        string `json:"time"`
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/api/status", statusHandler).Methods("GET")
	http.Handle("/", r)

	port := os.Getenv("PORT")

	log.Fatal(http.ListenAndServe(":"+port, nil))
}

func checkMySQL() (string, error) {
	db, err := sql.Open("mysql", os.Getenv("DATABASE_URL"))
	if err != nil {
		return "", fmt.Errorf("error connecting to MySQL: %w", err)
	}
	defer db.Close()

	var time string
	err = db.QueryRow("SELECT NOW() as time").Scan(&time)
	if err != nil {
		return "", fmt.Errorf("error querying MySQL: %w", err)
	}
	return time, nil
}

func checkRedis() error {
	client := redis.NewClient(&redis.Options{
		Addr:     os.Getenv("REDIS_URL"),
		Password: "",
		DB:       0,
	})

	_, err := client.Ping().Result()
	if err != nil {
		return fmt.Errorf("error connecting to Redis: %w", err)
	}

	return nil
}

func statusHandler(w http.ResponseWriter, r *http.Request) {
	time, err := checkMySQL()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		log.Println(err)
		return
	}

	err = checkRedis()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		log.Println(err)
		return
	}

	response := Response{
		RequestUUID: uuid.New().String(),
		Time:        time,
	}

	jsonResponse, err := json.Marshal(response)
	if err != nil {
		http.Error(w, "error marshalling response", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(jsonResponse)
}
