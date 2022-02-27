def handler(event, context):
    print(event)
    return {
        "status": 200,
        "text": "Thanks for working",
        "headers": {
            'Content-Type': 'application/json',
        }
    }
