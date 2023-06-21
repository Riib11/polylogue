import * as openai from 'polylogue-base/build/api/openai'
import * as vertex from 'polylogue-base/build/api/google-vertex'
import { GoogleAuth, OAuth2Client } from 'google-auth-library'
import { config } from 'dotenv'
config()

/*
export default async function main() {
  const result = await chat(process.env.openai_api_key, {
    'model': 'gpt-3.5-turbo',
    'messages': [
      { 'role': 'user', 'content': 'Hello, world!' }
    ]
  })
  console.log(result.choices.map(choice => choice.message.content))
}
*/

/*
export default async function main() {
  const auth = new GoogleAuth({
    credentials: {
      client_email: process.env.gcloud_auth_client_email,
      private_key: process.env.gcloud_auth_private_key,
    },
    projectId: process.env.gcloud_auth_projectId,
    scopes: "https://www.googleapis.com/auth/cloud-platform"
  })
  const client = await auth.getClient() as OAuth2Client

  const result = await vertex.chat({
    client,
    api_endpoint: 'us-central1-aiplatform.googleapis.com',
    project_id: 'cardcrafters',
    model_id: 'chat-bison@001',
    messages: [
      { author: 'user', content: 'Hello world!' }
    ],
    parameters: {
      temperature: 0.6,
      maxOutputTokens: 100,
      topP: 1,
      topK: 0
    }
  })
*/
