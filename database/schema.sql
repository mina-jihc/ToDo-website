create table app_users (
    id serial primary key,
    name varchar(50) not null
);

create table tasks (
    id serial primary key,
    user_id integer references app_users(id) not null,
    title varchar(100) not null,
    completed boolean default false  
);

create table tags (
    id serial primary key,
    name varchar(50) unique not null
);

create table task_tags (
    task_id integer references tasks(id) on delete cascade,
    tag_id integer references tags(id) on delete cascade,
    primary key (task_id, tag_id)
);