-- DATA ANALYSIS USING SQL ON MUSICS DATABASE--
/* WHO IS THE SENIOMOST EMPLOYEE BASED ON THE JOB TITLE ?--*/
SELECT * FROM EMPLOYEE;
-- HERE WE CAN SEE A LEVEL COLUMNS ASSIGNED HENCE THE SENIORMOST WILL BE THE HIGHEST LEVEL
SELECT EMPLOYEE_ID ,FIRST_NAME , LAST_NAME FROM employee 
ORDER BY LEVELS DESC
LIMIT 1; 

 -- WHICH COUNTRY HAS THE MOST INVOICES--

-- CHECKING THE INVOICE TABLES --
  SELECT COUNT(INVOICE_ID) , BILLING_COUNTRY FROM INVOICE 
  GROUP BY BILLING_COUNTRY ORDER BY COUNT(INVOICE_ID) DESC
  LIMIT 1;
  
  -- WHAT ARE TOP 3 VALUES OF TOTAL INVOICE--
  SELECT TOTAL,BILLING_COUNTRY FROM INVOICE 
  ORDER BY TOTAL DESC LIMIT 3;
  
 /* -- WHICH CITY HAS BEST CUSTOMERS ? WE WOULD LIKE TO THROW A PROMOTIONAL MUSIC FEST IN THE CITY WE MADE THE MOST ,
  WRITE A QUERY THAT RETURNS THE CITY THAT HAS MAXIMUM INVOICE TOTALS ,RETURN BOTH THE CITY NAME AND THE SUM OF ALL INVOICE TOTALS */
  
SELECT * FROM INVOICE;

 SELECT SUM(TOTAL) AS TOTAL_INVOICE ,BILLING_CITY FROM invoice
 GROUP BY BILLING_CITY ORDER BY SUM(TOTAL) desc LIMIT 1;
 
 /* WHO IS THE BEST CUSTOMER THE CUSTOMER WHO HAS SPENT THE MOST MONEY ?*/
SELECT * FROM CUSTOMER;
   # HERE WE CAN SEE THE THE CUSTOMER NAME IS NOT IN THE INVOICE TABLE HENCE WE NEED TO JOIN THESE TWO TABLES IN ORDER TO FIND THE BEST CUSTOMER 
select * from invoice;
SELECT  c.customer_id,c.first_name,c.last_name , sum(i.total) as totals from customer c
join invoice i on c.customer_id=i.customer_id
group by c.customer_id
order by sum(invoice.total) desc
limit 1;


# write a query to return the email , first name ,lastanme and genre of all rock music listeners , return the list ordered alphabetically by email
select distinct(email), first_name , last_name  from customer join invoice on customer.customer_id=invoice.invoice_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id where track_id in (select track_id from track join genre
on track.genre_id=genre.genre_id where  genre.name like "Rock")
order by email;

# lets invite the artists who have written the most rock music in our dataset . write a query that returns the artist name and total track count of the top 10 rack bands
select artist.artist_id ,  artist.name , count(artist.artist_id) as  number_of_songs
from track join  album2 on track.album_id=album2.album_id
join artist on album2.artist_id=artist.artist_id
join genre on track.genre_id=genre.genre_id
where genre.name like "Rock"
group by artist.artist_id
order by count(artist.artist_id) desc 
limit 10;

-- return the song names that have a song lenth longer than the average 
select * from track;
select milliseconds, name from track where milliseconds > 
(select avg(milliseconds) from track)
order by milliseconds desc limit 5;