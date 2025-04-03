-- 問題1. postgresqlでpracticeデータベースを生成するSQL文を記述してください。
CREATE DATABASE practice;

-- 問題2. postgresqlでpracticeデータベースのusersテーブルを生成するSQL文を記述してください。
-- ENUM型を定義（まだ定義されていない場合）
CREATE TYPE gender_enum AS ENUM ('Man', 'Woman', 'Other');
CREATE TABLE users (
    id SERIAL PRIMARY KEY,                          
    name CHAR(255) NOT NULL DEFAULT '',            
    age INT NOT NULL DEFAULT 0,                    
    gender gender_enum NOT NULL DEFAULT 'Other'    -- ENUM型を使用
);

-- 問題3. postgresqlでpracticeデータベースのjobsテーブルを生成するSQL文を記述してください。
CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    name CHAR(255) NOT NULL DEFAULT '会社員',
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users(id)
);