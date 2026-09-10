import { app } from "../src/app.js";

type VercelRequest = {
	method?: string;
	url?: string;
	headers: Record<string, string | string[] | undefined>;
};

type VercelResponse = {
	setHeader: (name: string, value: string) => void;
	status: (code: number) => VercelResponse;
	send: (body: string) => void;
};

export default async function handler(
	request: VercelRequest,
	response: VercelResponse,
) {
	const protocol = request.headers["x-forwarded-proto"] ?? "https";
	const host = request.headers.host ?? "localhost";
	const requestUrl = new URL(request.url ?? "/", `${protocol}://${host}`);
	const honoRequest = new Request(requestUrl, {
		method: request.method,
		headers: request.headers as HeadersInit,
	});
	const honoResponse = await app.fetch(honoRequest);

	honoResponse.headers.forEach((value, key) => {
		response.setHeader(key, value);
	});

	response.status(honoResponse.status).send(await honoResponse.text());
}
