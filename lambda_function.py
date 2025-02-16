import pycaesarcipher
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def decrypt_message(encrypted_message: str) -> str:
    """
    Decodes a message that was encrypted using the Caesar cipher.

    Parameters:
    encrypted_message (str): The message to be decoded.

    Returns:
    str: The decoded message.
    """
    shift_key = 3
    cipher_suite = pycaesarcipher.pycaesarcipher()
    decrypted_text = cipher_suite.caesar_decipher(encrypted_message, shift_key)
    return decrypted_text

def lambda_handler(event, context):
    for record in event["Records"]:
        # GET THE FILE NAME FROM THE S3 EVENT
        # Hint: The S3 event record contains information about the file that triggered the event.
        # Hint: The file name is located within the "s3" key of the event record.
        # Hint: Inside the "s3" key, look for the "object" key which contains details about the S3 object.
        # Hint: The actual file name is stored in the "key" key within the "object" key.
        # file_name = <your code here>
        try:
            # DECRYPT THE FILE NAME USING CAESAR CIPHER
            # Hint: Use the decrypt_message function to decrypt the file name.
            # decrypted = <your code here>
            logger.info(f"Decrypted message: {decrypted}")
        except Exception as e:
            logger.error(f"Failed to decrypt file name: {e}")
