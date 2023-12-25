#include "C:/Program Files/PostgreSQL/16/include/libpq-fe.h"
#include <iostream>

void print_table(const std::string &table) {
  for (size_t i = 0; i < table.size(); i++) {

    std::cout << table[i];
    if (table[i] == ';') {
      std::cout << '\n';
    }
  }
}

std::string get_table(std::string table_name, PGconn *conn) {
  std::string str;
  std::string query = "select * from ";
  query.append(table_name + ";");

  const char *cstr_query = query.c_str();
  PGresult *res = PQexec(conn, cstr_query);

  for (size_t i = 0; i < PQnfields(res); i++) {
    std::string column_name = PQfname(res, i);
    str.append(column_name + "--");
  }
  str.pop_back();
  str.pop_back();
  str.push_back(';');

  for (size_t i = 0; i < PQntuples(res); i++) {
    for (size_t j = 0; j < PQnfields(res); j++) {
      std::string cell = PQgetvalue(res, i, j);
      str.append(cell + "--");
    }
    str.pop_back();
    str.pop_back();
    str.push_back(';');
  }

  return str;
}
