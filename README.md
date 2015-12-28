# Ithaca College Directory Slack Integration

This simple Ruby/Sinatra script allows Slack Slash Command integration with the [Ithaca College Directory](https://www.ithaca.edu/directories/index.php).

The script parses the HTML of the directory page, and formats the results for Slack.

### Endpoint
```
GET /search/?text=NAME
```

### Response
```json
{
  "text": "1 results found.",
  "attachments": [
    {
      "title": "Name",
      "text": "Information",
      "color": "#004080",
      "mrkdwn_in": ["text"]
    }
  ]
}

```

Feel free to use this script, file issues, or contribute!
