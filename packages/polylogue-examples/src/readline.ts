import * as readline from 'readline';

export default async function main() {
  const cli = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  })

  await cli.question("Enter some text: ", input => {
    console.log(`input: ${input}`)
    cli.close()
  })
}
