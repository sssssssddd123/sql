-- =====================================
-- 0️⃣ 기존 테이블과 시퀀스 삭제 (완전 삭제, PURGE)
-- =====================================
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE my_page CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE todolist CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE comment_all CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE post CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE users CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_user';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_post';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_comment';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq2_comment';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_todo';
EXCEPTION WHEN OTHERS THEN NULL; END;
/


-- =====================================
-- 0️⃣ 시퀀스 생성
-- =====================================
CREATE SEQUENCE seq_user START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_post START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_comment START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_todo START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- =====================================
-- 1️⃣ 테이블 생성 (원본 구조, PK 유지)
-- =====================================
CREATE TABLE comment_all (
    comment_no    NUMBER(5, 0) NOT NULL,
    post_no       NUMBER(5, 0) NOT NULL,
    user_id       VARCHAR2(20 BYTE) NOT NULL,
    post_comment  VARCHAR2(100 BYTE) NOT NULL,
    created_at    DATE NOT NULL
);

CREATE TABLE todolist (
    todo_no       NUMBER(5, 0) NOT NULL,
    user_id       VARCHAR2(20 BYTE) NOT NULL,
    todo_content  VARCHAR2(50 BYTE) NULL
);

CREATE TABLE my_page (
    user_id      VARCHAR2(20 BYTE) NOT NULL,
    post_no      NUMBER(5, 0) NOT NULL,
    comment_no   NUMBER(5, 0) NOT NULL
);

CREATE TABLE users (
    user_no   NUMBER(5, 0) NOT NULL,
    user_id   VARCHAR2(20 BYTE) NOT NULL,
    user_pw   VARCHAR2(20 BYTE) NOT NULL,
    name      VARCHAR2(10 BYTE) NOT NULL,
    tel       VARCHAR2(20 BYTE) NOT NULL
);

CREATE TABLE post (
    post_no       NUMBER(5, 0) NOT NULL,
    user_id       VARCHAR2(20 BYTE) NOT NULL,
    post_title    VARCHAR2(20 BYTE) NOT NULL,
    post_content  VARCHAR2(1000 BYTE) NOT NULL,
    created_at    DATE NOT NULL,
    updated_at    DATE NOT NULL
);

ALTER TABLE comment_all ADD CONSTRAINT PK_COMMENT_ALL PRIMARY KEY (comment_no);
ALTER TABLE todolist ADD CONSTRAINT PK_TODOLIST PRIMARY KEY (todo_no);
ALTER TABLE users ADD CONSTRAINT PK_USERS PRIMARY KEY (user_no, user_id);
ALTER TABLE post ADD CONSTRAINT PK_POST PRIMARY KEY (post_no);

-- =====================================
-- 2️⃣ INSERT 예시
-- =====================================

-- 2-1. 회원가입 (users)
INSERT INTO users (user_no, user_id, user_pw, name, tel)
VALUES (seq_user.NEXTVAL, 'hong', '1234', '홍길동', '010-1234-5678');

-- 2-2. 게시글 작성 (post) + 댓글 (comment_all) + my_page
DECLARE
  v_post_no NUMBER;
BEGIN
  v_post_no := seq_post.NEXTVAL;
  INSERT INTO post (post_no, user_id, post_title, post_content, created_at, updated_at)
  VALUES (v_post_no, 'hong', '세 번째 글', '게시글 내용', SYSDATE, SYSDATE);

  -- 댓글 작성
  DECLARE
    v_comment_no NUMBER;
  BEGIN
    v_comment_no := seq_comment.NEXTVAL;
    INSERT INTO comment_all (comment_no, post_no, user_id, post_comment, created_at)
    VALUES (v_comment_no, v_post_no, 'hong', '첫 댓글', SYSDATE);

    -- my_page 데이터
    INSERT INTO my_page (user_id, post_no, comment_no)
    VALUES ('hong', v_post_no, v_comment_no);
  END;
END;
/

-- 2-3. 할 일 추가 (todolist)
INSERT INTO todolist (todo_no, user_id, todo_content)
VALUES (seq_todo.NEXTVAL, 'hong', '첫 할 일');

--------------------------------------------------------------------------------

SELECT * FROM comment_all;

SELECT * FROM todolist;

SELECT * FROM my_page;

SELECT * FROM post;

SELECT * FROM users;

--------------------------------------------------------------------------------
