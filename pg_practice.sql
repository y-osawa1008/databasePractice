-- 問題1. postgresqlでpracticeデータベースを生成するSQL文を記述してください。
CREATE DATABASE practice;

-- 問題2. postgresqlでpracticeデータベースのusersテーブルを生成するSQL文を記述してください。
CREATE TABLE users (
    id SERIAL PRIMARY KEY,                          -- MySQLの AUTO_INCREMENT → PostgreSQLでは SERIAL
    name CHAR(255) NOT NULL DEFAULT '',            -- "氏名"（固定長文字列）
    age INT NOT NULL DEFAULT 0,                    -- "年齢"（整数）
    gender VARCHAR(10) NOT NULL DEFAULT 'Other',   -- "性別"（MySQLの ENUM を VARCHAR に変更）
    CONSTRAINT gender_check CHECK (gender IN ('Man', 'Woman', 'Other')) -- ENUM の代わりに CHECK 制約を使用
    );

-- 問題3. postgresqlでpracticeデータベースのjobsテーブルを生成するSQL文を記述してください。
CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    name CHAR(255) NOT NULL DEFAULT '会社員',
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id)
);