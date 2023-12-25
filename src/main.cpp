#include "C:/Program Files/PostgreSQL/16/include/libpq-fe.h"
#include "CRUD.cpp"
#include <cstdio>
#include <iostream>
#include <locale.h>
#include <ostream>
#include <string>

// Online_Learning_Platform
int main() {
  setlocale(LC_ALL, "Turkish.UTF-8");

  const char *conn_info =
      "host=localhost user=postgres password=1234 port=5432 "
      "dbname=test connect_timeout=10";

  PGconn *conn = PQconnectdb(conn_info);

  if (PQstatus(conn) == CONNECTION_BAD) {
    std::cout << "CONNECTION BAD!\n" << PQerrorMessage(conn) << std::endl;
    return 1;
  }
  std::cout << "CONNECTION OK!\n";

  std::string employees_table = get_table("\"public\".\"categories\"", conn);
  print_table(employees_table);
  // const char *query = "select * from \"public\".\"employees\";";
  // PGresult *res = PQexec(conn, query);
  // std::cout << PQgetvalue(res, 0, 2) << std::endl;

  return 0;
}