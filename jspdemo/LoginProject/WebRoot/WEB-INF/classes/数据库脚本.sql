DROP TABLE member PURGE ;
CREATE TABLE member(
	mid			VARCHAR2(30) ,
	password	VARCHAR2(32) ,
	CONSTRAINT pk_mid PRIMARY KEY(mid)
) ;
INSERT INTO member(mid,password) VALUES ('admin','hello') ;
INSERT INTO member(mid,password) VALUES ('cfxyz','java') ;
COMMIT ;