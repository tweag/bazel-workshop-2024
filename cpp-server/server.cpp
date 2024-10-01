#include <crow.h>
#include <map>

enum CookieStatus {
  IN_PREPARATION = 1,
  IN_DELIVERY,
  DONE
};

std::map<uint64_t, CookieStatus> cookie_db{};
std::array<std::string_view, 2> flavors{"chocolate", "vanilla"};

uint64_t next_id() {
  return cookie_db.size();
}

const char* status_to_string(CookieStatus status) {
  switch(status) {
  case IN_PREPARATION:
    return "IN_PREPARATION";
  case IN_DELIVERY:
    return "IN_DELIVERY";
  case DONE:
    return "DONE";
  };
  return "NO_STATUS";
}

int main() {
  crow::SimpleApp app;

  CROW_ROUTE(app, "/api/orders/<uint>/status")
  ([](uint64_t id) {
     auto status = cookie_db.find(id);
     if (status == cookie_db.end())
       return crow::response(404);

     crow::json::wvalue res({{ "id", id }, { "status", status_to_string(status->second) }});
     return crow::response(res);
   });

  CROW_ROUTE(app, "/api/cookies/<string>/<uint>").methods("POST"_method)
  ([](std::string flavor, uint64_t desired_number) {
    if (std::find(flavors.begin(), flavors.end(), flavor) == flavors.end())
      return crow::response(400);
     
     auto id = next_id();
     auto status = std::array<CookieStatus, 3>{IN_PREPARATION, IN_DELIVERY, DONE}[desired_number % 3];
     cookie_db.emplace(std::make_pair(id, status));

     crow::json::wvalue res({ { "flavor", flavor }, { "desired_number", desired_number }, { "id", id } });
     return crow::response(res);
   });
  app.port(9999).run();
}
