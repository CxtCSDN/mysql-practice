CREATE TABLE
`t_dept` ( `id` INT(11) NOT NULL AUTO_INCREMENT, 
`deptName` VARCHAR(30) DEFAULT NULL, 
`address` VARCHAR(40) DEFAULT NULL, PRIMARY KEY (`id`) ) 
ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; 

CREATE TABLE `t_emp` ( 
`id` INT(11) NOT NULL AUTO_INCREMENT, 
`name` VARCHAR(20) DEFAULT NULL, 
`age` INT(3) DEFAULT NULL, 
`deptId` INT(11) DEFAULT NULL, 
empno INT NOT NULL, 
PRIMARY KEY (`id`), 
KEY `idx_dept_id` (`deptId`) 
#CONSTRAINT `fk_dept_id` FOREIGN KEY (`deptId`) REFERENCES `t_dept` (`id`) 
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO t_dept(deptName,address) VALUES('华山','华山'); 
INSERT INTO t_dept(deptName,address) VALUES('丐帮','洛阳'); 
INSERT INTO t_dept(deptName,address) VALUES('峨眉','峨眉山'); 
INSERT INTO t_dept(deptName,address) VALUES('武当','武当山'); 
INSERT INTO t_dept(deptName,address) VALUES('明教','光明顶'); 
INSERT INTO t_dept(deptName,address) VALUES('少林','少林寺'); 
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('风清扬',90,1,100001); 
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('岳不群',50,1,100002); 
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('令狐冲',24,1,100003); 
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('洪七公',70,2,100004); 
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('乔峰',35,2,100005); 
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('灭绝师太',70,3,100006); 
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('周芷若',20,3,100007); 
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('张三丰',100,4,100008); 
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('张无忌',25,5,100009); `t_dept``t_emp``t_dept`
INSERT INTO t_emp(NAME,age,deptId,empno) VALUES('韦小宝',18,NULL,100010);

#1.所有有门派的人员信息 （ A、B两表共有） 
SELECT td.`deptName`,te.`name`
FROM t_dept td JOIN t_emp te
ON td.`id` = te.`deptId`;

#2.列出所有用户，并显示其机构信息 （A的全集） 
SELECT te.`name`,td.`deptName`
FROM t_dept td RIGHT JOIN t_emp te
ON td.`id` = te.`deptId`;

#3.列出所有门派 （B的全集） 
SELECT *
FROM t_dept;

#4.所有不入门派的人员 （A的独有） 
SELECT te.`id`,te.`name`,td.`deptName`
FROM t_dept td RIGHT JOIN t_emp te
ON td.`id` = te.`deptId`
WHERE te.`deptId` IS NULL;

#5.所有没人入的门派 （B的独有）
SELECT deptName
FROM t_dept d LEFT JOIN t_emp e
ON d.`id` = e.`deptId`
WHERE e.`deptId` IS NULL;

#6.列出所有人员和机构的对照关系 (AB全有) 
SELECT e.`name`,d.`deptName`
FROM t_dept d LEFT JOIN t_emp e
ON d.`id` = e.`deptId`
WHERE e.`deptId` IS NULL
UNION ALL
SELECT te.`name`,td.`deptName`
FROM t_dept td RIGHT JOIN t_emp te
ON td.`id` = te.`deptId`;

#MySQL Full Join的实现 因为MySQL不支持FULL JOIN,下面是替代方法 
#left join + union(可去除重复数据)+ right join 

#7.列出所有没入派的人员和没人入的门派 （A的独有+B的独有）
SELECT e.`name`,d.deptName
FROM t_dept d LEFT JOIN t_emp e
ON d.`id` = e.`deptId`
WHERE e.`deptId` IS NULL
UNION ALL
SELECT te.`name`,td.`deptName`
FROM t_dept td RIGHT JOIN t_emp te
ON td.`id` = te.`deptId`
WHERE te.`deptId` IS NULL;
