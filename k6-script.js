import http from "k6/http";
import { check, sleep } from "k6";


export default function() {
  let res = http.get("http://127.0.0.1:8080/feature/test3");
  check(res, {
    "status was 200": (r) => r.status == 200
  });
//  sleep(1);
};
