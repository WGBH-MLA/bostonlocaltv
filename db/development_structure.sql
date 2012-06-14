CREATE TABLE "bookmarks" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "document_id" varchar(255), "title" varchar(255), "created_at" datetime, "updated_at" datetime, "user_type" varchar(255));
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "searches" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "query_params" text, "user_id" integer, "created_at" datetime, "updated_at" datetime, "user_type" varchar(255));
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_searches_on_user_id" ON "searches" ("user_id");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20111031172142');

INSERT INTO schema_migrations (version) VALUES ('20111031172149');

INSERT INTO schema_migrations (version) VALUES ('20111031172150');

INSERT INTO schema_migrations (version) VALUES ('20111031172151');

INSERT INTO schema_migrations (version) VALUES ('20111031172152');