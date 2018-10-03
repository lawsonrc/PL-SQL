/* 
  Programmer's Name: Ryan Lawson & Christie Sutton 
  Course: CSCI 3020 Section Number: 090
  Creation Date: 7/19/2017
  E-mail Address:lawsonrc@etsu.edu & zcas69@etsu.edu 
  Project Name: Project 3
*/

/*Find the avg of puchased listprice and salesprice by state*/
Select a.state, AVG(p.LISTPRICE)AS LISTPRICE, AVG(p.SALESPRICE)AS SALESPRICE 
From Purchase p
LEFT Join store s
  on p.STOREID = s.STOREID
Left Join Address a
  on s.ADDRESSID = a.ADDRESSID
Group By (a.state)
ORDER BY a.state ASC;

/*Find the avg of purchased listprice and salesprice by store.*/
SELECT  s.STORENAME,a.state, AVG(p.LISTPRICE)AS LISTPRICE, AVG(p.SALESPRICE)AS SALESPRICE 
FROM Purchase p
LEFT JOIN store s
 ON p.STOREID = s.STOREID
Left Join Address a
  on s.ADDRESSID = a.ADDRESSID
GROUP BY ROLLUP(s.STORENAME, a.state)
ORDER BY s.STORENAME, a.state;

/*Most popular paint color. What store sells the most popular hair color.*/

SELECT st.STORENAME,p.ColorName, COUNT(p.PAINTID)AS PaintType 
FROM BICYCLE b
LEFT JOIN PAINT p
 ON b.PAINTID = p.PAINTID
LEFT JOIN PURCHASE pu
  ON b.SERIALNUMBER = pu.BICYCLESERIALNUMBER
LEFT JOIN STORE st
  ON pu.STOREID = st.STOREID
GROUP BY CUBE(st.STORENAME,p.ColorName);

/*What Part Manufacturers are the most popular by store?*/

SELECT  st.STORENAME, p.MANUFACTURERNAME, COUNT(p.PARTID) AS MostPopular
FROM PART p
LEFT JOIN COMPONENTS c
  ON p.PARTID = c.PARTID
LEFT JOIN PURCHASE pu
  ON c.BICYCLESERIALNUMBER = pu.BICYCLESERIALNUMBER
LEFT JOIN STORE st
  ON pu.STOREID = st.STOREID
GROUP BY CUBE(p.MANUFACTURERNAME, st.STORENAME)
ORDER BY st.STORENAME, p.MANUFACTURERNAME;









