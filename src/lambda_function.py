from cryptography.fernet import Fernet
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Example: Decrypt the file name (assuming a shared key)
SECRET_KEY = b'mysecretkey1234567890=='  # Replace with a real key
cipher = Fernet(SECRET_KEY)

def lambda_handler(event, context):
    for record in event["Records"]:
        file_name = record["s3"]["object"]["key"]
        try:
            decrypted_message = cipher.decrypt(file_name.encode()).decode()
            logger.info(f"Decrypted message: {decrypted_message}")
        except Exception as e:
            logger.error(f"Failed to decrypt file name: {e}")
    return {"statusCode": 200, "body": "Processed"}
