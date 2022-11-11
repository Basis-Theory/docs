# Limits

The Basis Theory API has rate limits applied to ensure the speed and consistency of our systems. 

- Our services are restricted to 600 requests per IP, per minute, per [Application](/api-reference/#applications)

### Error Codes
Error Code | Meaning
---------- | -------
`429` | Request has been rate limited
