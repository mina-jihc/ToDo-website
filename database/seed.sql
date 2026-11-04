insert into app_users (name) values ('Kate');
insert into app_users (name) values ('Dan');
insert into app_users (name) values ('Jane');
insert into app_users (name) values ('Ed');

insert into tasks (user_id, title) values (1, 'Study web');
insert into tasks (user_id, title, completed) values (1, 'Go to the cafe', true);
insert into tasks (user_id, title) values (2, 'Read a book');
insert into tasks (user_id, title, completed) values (2, 'Buy products', true);
insert into tasks (user_id, title) values (3, 'Present a topic');
insert into tasks (user_id, title, completed) values (3, 'Watch a film', true);

insert into tags (name) values ('Work');
insert into tags (name) values ('Urgent');
insert into tags (name) values ('Personal');
insert into tags (name) values ('Study');

insert into task_tags (task_id, tag_id) values (1, 4); 
insert into task_tags (task_id, tag_id) values (2, 3); 
insert into task_tags (task_id, tag_id) values (3, 2); 
insert into task_tags (task_id, tag_id) values (4, 1); 
insert into task_tags (task_id, tag_id) values (5, 4); 
insert into task_tags (task_id, tag_id) values (6, 3); 
insert into task_tags (task_id, tag_id) values (1, 2);  
insert into task_tags (task_id, tag_id) values (3, 1); 
insert into task_tags (task_id, tag_id) values (5, 2);  
