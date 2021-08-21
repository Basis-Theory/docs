# Limits

The Basis Theory API has rate limits applied to ensure the speed and consistency of our systems. 

- Our Elements are restricted to 10 requests per IP, per second, per [Application](/api-reference/#applications)
- Our APIs are restricted to 100 requests per IP, per second, per [Application](/api-reference/#applications)

### Error Codes
Error Code | Meaning
---------- | -------
`429` | Request has been rate limited
