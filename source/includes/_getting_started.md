# Getting Started

To get started using Basis Theory to tokenize any data, follow these steps:

1. Create an [Application](#applications) and obtain an [API Key](#authentication)
    1. Log in or create an account through the <a href="https://portal.basistheory.com/" target="_blank">Basis Theory Portal</a>
    1. Navigate to the <a href="https://portal.basistheory.com/applications" target="_blank">Applications</a> page and click `Create Application`
    1. Follow the on-screen prompts to name the application and choose the appropriate [Application Type](#application-types) based on your use-case
    1. Copy the API Key generated and acknowledge the prompt
1. View the newly created application's details (Portal will redirect to this page after successful application creation)
1. Assign the necessary permissions to the created Application
   - More information about Permission Types can be found [here](#permission-types)

<aside class="notice">
    <span>If a Basis Theory API responds with <code>403 FORBIDDEN</code>, it is likely due to the application lacking the appropriate permissions for that endpoint.
    Inspect the <code>WWW-Authenticate</code> response header for more information about the necessary permissions.</span>
</aside>
