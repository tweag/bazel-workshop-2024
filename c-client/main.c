#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <curl/curl.h>

void help() {
  fprintf(stderr, "Usage: cookie_client -u <BASE_URL> [-o -f <FLAVOR> -n <NUMBER> | -s <ID>]\n");
}

void order(const char* base_url, const char* flavor, uint64_t number) {
  char url[256] = {0};

  snprintf(url, 255, "%s/api/cookies/%s/%lu", base_url, flavor, number);

  curl_global_init(CURL_GLOBAL_ALL);

  CURL* curl = curl_easy_init();
  if (!curl) goto global_cleanup;

  curl_easy_setopt(curl, CURLOPT_URL, url);
  curl_easy_setopt(curl, CURLOPT_POSTFIELDS, "");
  CURLcode res = curl_easy_perform(curl);
  if (res != CURLE_OK) {
    fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
  }

  curl_easy_cleanup(curl);
global_cleanup:
  curl_global_cleanup();
}

void status(const char* base_url, uint64_t id) {
  char url[256] = {0};

  snprintf(url, 255, "%s/api/orders/%lu/status", base_url, id);

  curl_global_init(CURL_GLOBAL_ALL);

  CURL* curl = curl_easy_init();
  if (!curl) goto global_cleanup;

  curl_easy_setopt(curl, CURLOPT_URL, url);
  CURLcode res = curl_easy_perform(curl);
  if (res != CURLE_OK) {
    fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
  }

  curl_easy_cleanup(curl);
global_cleanup:
  curl_global_cleanup();
}

int main(int argc, char** argv) {
  int opt;
  const char* base_url = 0;

  const char* flavor = 0;
  uint64_t number = 0, id = 0;

  bool do_order = false, do_status = false;

  while ((opt = getopt(argc, argv, "hu:f:n:os:")) != -1) {
    switch(opt) {
      case 'u':
        base_url = optarg;
        break;
      case 'f':
        flavor = optarg;
        break;
      case 'n':
        number = atoi(optarg);
        break;
      case 'o':
        do_order = true;
        break;
      case 's':
        do_status = true;
        id = atoi(optarg);
        break;
      default:
        help();
        exit(0);
    }
  }

  if (do_order && do_status) {
    help();
    exit(0);
  }

  if (do_order) {
    order(base_url, flavor, number);
  } else if (do_status) {
    status(base_url, id);
  } else {
    help();
    exit(0);
  }
  return 0;
}
