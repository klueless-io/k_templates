import type { IncomingMessage, ServerResponse } from "http"
import * as url from "url"

export default async (req: IncomingMessage, res: ServerResponse) => {
  // movie?id=123
  // { id: 123 }
  // https://api.tvmaze.com/shows/665
  const queryObject = url.parse(req.url as string, true).query;

  let data = { data: [{data: ""}]}
  const { id } = queryObject

  if (id) {
    data = await $fetch(`https://api.tvmaze.com/shows/${id}`)
  }

  res.writeHead(200, {"Content-Type": "application/json"})
  res.write(JSON.stringify(data))
  res.end()
  // return {
  //   foo: "bar",
  // };
};