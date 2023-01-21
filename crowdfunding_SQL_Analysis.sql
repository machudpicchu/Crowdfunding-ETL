-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cpgn.backers_count, cpgn.cf_id, cpgn.outcome
FROM campaign as cpgn
WHERE (cpgn.outcome = 'live')
ORDER BY cpgn.backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT COUNT (bkr.cf_id), bkr.cf_id
FROM backers as bkr
GROUP BY bkr.cf_id
ORDER BY COUNT(bkr.cf_id) DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
--NEW NAME FOR TABLE email_contacts_remaining_goal_amount
SELECT con.first_name, con.last_name, con.email, (cpgn.goal - cpgn.pledged) as remaining_goal_amount 
INTO email_contacts_remaining_goal_amount
FROM campaign as cpgn
INNER JOIN contacts as con
ON (cpgn.contact_id = con.contact_id)
WHERE (cpgn.outcome = 'live')
ORDER BY remaining_goal_amount DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT bck.email, bck.first_name, bck.last_name, cpgn.cf_id, cpgn.company_name, cpgn.description, (cpgn.goal - cpgn.pledged) as left_of_goal 
INTO email_backers_remaining_goal_amount
FROM campaign as cpgn
INNER JOIN backers as bck
ON (cpgn.cf_id = bck.cf_id)
WHERE (cpgn.outcome = 'live')
ORDER BY bck.last_name, bck.email;


-- Check the table

SELECT * FROM email_backers_remaining_goal_amount;
