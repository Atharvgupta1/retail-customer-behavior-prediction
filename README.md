# 🛒 Retail Customer Intelligence & Churn Prediction

## 📌 Overview

This project transforms raw retail transaction data into **actionable business insights** and extends it with a **customer churn prediction model**.

It follows an end-to-end workflow:

* Data Cleaning (Python)
* Machine Learning (Churn Prediction)
* Business Analysis (SQL)
* Visualisation (Power BI)

---

## 🚨 Business Problem

The business lacks visibility into:

* Customer retention and churn risk
* Key revenue drivers
* Product performance and seasonality

This leads to reactive decision-making instead of **data-driven strategy**.

---

## 🎯 Objectives

* Analyse **revenue trends and performance**
* Identify **top-performing products**
* Understand **customer behavior patterns**
* Build a **churn prediction model**
* Provide **actionable business recommendations**

---

## 🛠️ Tech Stack

* **Python** → Data cleaning, feature engineering, ML
* **SQL (MySQL)** → Business analysis
* **Power BI** → Dashboard & visualization
* **Scikit-learn** → Machine learning

---

## 📂 Dataset Information

* **Source:** UCI Machine Learning Repository
* **Dataset:** Online Retail Dataset
* **Link:** https://archive.ics.uci.edu/ml/datasets/online+retail

Contains ~500K retail transactions (2010–2011), including:

* InvoiceNo, StockCode, Description
* Quantity, InvoiceDate
* UnitPrice, CustomerID, Country

---

## 📊 Dashboard Preview

![Dashboard](dashboard/dashboard_preview.png)

---

## 📊 Key Metrics

* **Total Revenue:** 8.64M+
* **Total Orders:** 19K+
* **Total Customers:** 4.3K+
* **Average Order Value:** 167+

---

## 🔍 Key Insights

* Revenue shows **strong seasonal trends**
* A small number of products drive majority of sales
* Majority of customers are **one-time buyers (high churn risk)**
* Revenue depends heavily on **high-value customers**
* Sales are concentrated in a few key regions

---

## 🧠 SQL Analysis

* Revenue trends and seasonality
* Top products and categories
* Customer segmentation
* Customer lifetime value
* RFM feature extraction

---

## 🤖 Churn Prediction Model

* Built using **Logistic Regression & Random Forest**
* Features engineered using **RFM (Recency, Frequency, Monetary)**
* Identifies customers with **high probability of churn**

### Key Findings:

* High recency + low frequency → high churn risk
* Early identification enables targeted retention strategies

---

## 📊 Dashboard Features

* KPI overview (Revenue, Orders, Customers, Churn Rate)
* Monthly revenue trend
* Top products analysis
* Revenue by country
* Customer segmentation
* High-risk customers (churn prediction)

---

## 💡 Business Recommendations

* Implement **loyalty programs** to improve retention
* Target **high-risk customers** with personalized offers
* Focus on **top-performing products**
* Leverage seasonal demand patterns

---

## 🧾 Conclusion

This project demonstrates how combining **analytics and machine learning** enables businesses to move from descriptive insights to **predictive decision-making**, improving retention and long-term growth.

---
