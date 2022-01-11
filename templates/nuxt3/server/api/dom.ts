import type { IncomingMessage, ServerResponse } from "http"

export default async (req: IncomingMessage, res: ServerResponse) => {
  let data = { data: [{data: "123"}, {data: "345"}]}

  res.writeHead(200, {"Content-Type": "application/json"})
  res.write(JSON.stringify(data))
  res.end()
};