# <img src="https://avatars1.githubusercontent.com/u/7063040?v=4&s=200.jpg" alt="HU" width="24" /> Delta Challenge

[[English](README.md) | [English](README.pt.md)]

There will basically be 2 parts that we'll focus on in this test:

-   Your development skill.
-   Your ability to get code to run using specific technologies.

Some steps will have vague requirements or errors. There is no right or wrong answer, we want to assess your posture in the face of the challenge and how you will develop it.

#

# Part 1 - Development

## Prerequisites

-   Git
-   Github account

#

### How to make

The project must use version control in git and stored/uploaded to Github in a private repository in your account.

When you finish the challenge, invite the `automator-hurb` user to be a contributor to your challenge repository so we can take the assessment.

#

## The task

Using Go, Python3 or NodeJS, your task will be to implement a REST API that CRUDs products stored in a MySQL 5.7 database.

The API will have to validate the input data. Example: SKU is unique in POST and PUT.

#

## Requirements

-   Kubernetes deployment manifests to run, balance, limit requests and scale using HPA in Minikube v1.13.0

-   Script to populate the database with dummy data.

-   Unitary tests

## Third Party Libraries

You will be able to use third-party libraries such as the driver to talk to the database, but we encourage you to use as few libraries as possible.

# Product API

response codes

-   200 OK
-   201 Created
-   400 Bad Request
-   404 Not Found
-   500 Internal Server Error

---

All error responses (400, 404, 500) must return a unique object with a unique key called "errorText" and the value (string) describing the error.

Example:

```
{
 "errorText": "The error message"
}
```

## Definition of "product"

```
{
    "productId"​: ​<int>​, ​(readonly, unique)
    "title"​: ​<string>​, ​(required for POST)
​ "sku"​: ​<string>​, ​(required for POST, unique)
    "barcodes"​: ​[<string>]​, (unique)
    "description"​: <string|null>​, (default null)
    "attributes"​: ​[<attribute>]​, ​
    "price"​: ​<money>​, ​(default "0.00")
    "created"​: <timestamp>​, (readonly)
    "lastUpdated": <timestamp|null>​ (readonly)
}
```

## Endpoints

`GET /api/products`

**Query parameters**

All parameters are optional

| Parameter | Description                                            | Type                        | Default |
| --------- | ------------------------------------------------------ | --------------------------- | ------- |
| start     | Index start                                            | int                         | 0       |
| num       | Number of indexes returned                             | int                         | 10      |
| sku       | Filter by sku                                          | string                      | ---     |
| barcode   | Filter by barcode                                      | string                      |         |
| fields    | Product fields that will be returned from the response | string, separated by commas | ---     |

-   Example of URL

```
http://127.0.0.1:8080/api/products?start=40&num=2&fields=productId,title
```

-   Success return

```
{
"totalCount"​: <int>​,
"items"​: [​<product>​]
}
```

-   Sample return

```
{
​"totalCount"​: 126​,
"items"​: [
{
    "productId"​: 45​,
​ "title": "Awesome socks"
    },
    {
    "productId"​: 46​,
    "title"​: "Batman socks"
        }
    ]
}
```

---

## GET

```
GET /api/products/{productId}
```

**Query parameters**

All parameters are optional

| Parameter | Description                                            | Type                        | Default |
| --------- | ------------------------------------------------------ | --------------------------- | ------- |
| fields    | Product fields that will be returned from the response | string, separated by commas | ---     |

Example return success

```
{
"productId"​: 45​,
"title"​: "Awesome socks"​,
​"sku"​: "SCK-4511"​,
​"barcodes"​: [​"7410852096307"​],
"description"​: null​,
"attributes"​: [
    {
​ "name"​: "color"​,
​ "value"​: "Red"
    },
    {
        "name"​: "size"​,​
        "value"​: "39-41"
    },
],
"price"​: "89.00",
"created"​: 1554472112​,
​"lastUpdated"​: null
}
```

error return

```
{
"errorText"​: "Can’t find product (<productId>)"
}
```

---

## POST

```
POST​ /api/products
```

For POST, a product subset is allowed, but all fields required for creation must be present.

**Body** content

```
{
​"title": "Awesome socks"​,
"sku"​: "SCK-4511"​,
"barcodes"​: [​"7410852096307"​],
​"description"​: null​,
​"attributes"​: [
        {
​
            "name"​: "color"​,
            "value"​: "Red"​,
        },
        {
​ "name": "size"​,
            "value"​: "39-41"​,
        },
    ],
    ​"price"​: "89.00"​,
}
```

-   Success answer (int)

```
45
```

-   Error response

```
{
​"errorText"​: "SKU 'SCK-4511' already exists"
}
```

---

## PUT

```
PUT​ /api/products/{productId}
```

Again, a product subset is allowed.

Success return (bool)

```
true
```

error return

```
{
 "errorText": "​ Invalid sku, can not be null"
}
```

---

## DELETE

```
DELETE​ /api/products/{productId}
```

Success return (bool)

```
true
```

error return

```
{
​"errorText"​: "Product with productId (<productId>) does not exist"
}
```

# Definitions

## API Types

attributes

```
{
    "name"​: ​<string>​, ​(required)​
    "value"​: ​<string>​ ​(required)
}
```

## mysql schema

```
CREATE​ SCHEMA ​IF​ ​NOT​ ​EXISTS​ ​`hurb_test_assignment`
DEFAULT ​CHARACTER​ SET​ utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE​ ​TABLE​ ​IF​ ​NOT​ ​EXISTS​ ​`hurb_test_assignment`​.`product`​ (
`product_id`​ INT​ UNSIGNED ​NOT​ NULL​ AUTO_INCREMENT,
`title`​ VARCHAR​(32​) NOT​ NULL​,
`sku`​ VARCHAR​(32​) NOT​ NULL​,
`description`​ VARCHAR(1024​) NULL​,
`price`​ DECIMAL​(12​,2)NOT​ NULL​ DEFAULT ​0.00,
`created`​ DATETIME​ NOT​ NULL​,
`last_updated`​ DATETIME​ NULL,
PRIMARY​ KEY​ (​`product_id`​),
UNIQUE INDEX (​`sku`​ ASC​),
INDEX (​
`created`​
),
INDEX (​`last_updated`​)
);

CREATE​ ​TABLE​ ​IF​ ​NOT​ ​EXISTS​ ​`hurb_test_assignment`​.`product_barcode`​ (
`product_id`​ INT​ UNSIGNED ​NOT​ NULL​,
`barcode`​ VARCHAR(32​) NOT​ NULL​,
PRIMARY​ KEY​ (​`product_id`​, `barcode`​),
UNIQUE INDEX (​`barcode`​)
);

CREATE​ ​TABLE​ ​IF​ ​NOT​ ​EXISTS​ ​`hurb_test_assignment`​.`product_attribute`​ (
`product_id`​ INT​ UNSIGNED ​NOT​ NULL​,
`name`​ VARCHAR​(16​) NOT​ NULL​,
`value`​ VARCHAR​(32​) NOT​ NULL​,
PRIMARY​ KEY​ (​`product_id`​, `name`​)
);
```

# Part 2 - Application Delivery

-   Your application must run on Minikube v13.0 + kubectl
-   You must write the Kubernetes manifests to create _Ingresso_ to expose your app, 1 container to run your application and 1 container to run the Database. You should use K8s Services and deployments as well as HPA by setting request limits and system resource usage. The numbers of these limits should be low enough to be able to see the HPA take action from requests from the local machine.

*   All logs must be visible from `kubectl logs -f <pod>`

*   Cluster security will be taken into account.

*   The project should run using only 1 command (assuming the person already has the minikube installed and running).

## Evaluation criteria

-   **Organization of code**: Separation of modules - app and infra code.
-   **Clarity**: Does the README explain briefly what the problem is and how can I run the application?
-   **Assertiveness**: Is the application doing what is expected? If something is missing, does the README explain why?
-   **Code readability** (including comments)
-   **Security**: Are there any clear vulnerabilities that have not been addressed?
-   **Test coverage** Unit tests
-   **History of commits** (structure and quality, titles and description)
-   **Technical choices**: Is the choice of libraries, architecture, etc the best choice for the application?
-   **Communication**: If you couldn't complete the entire test, does the README contain what was missing?

## Doubts

Any questions you may have, check the [_issues_](https://github.com/HurbCom/challenge-delta/issues) to see if someone hasn't already and if you can't find your answer, open one yourself. new issue!

Good luck and good trip! ;)

<p align="center">
  <img src="ca.jpg" alt="Challange accepted" />
</p>
