TARGET_URL = 'http://192.168.1.100:3000/tests'
TARGET_SITE = "http://192.168.1.100:3000"
TARGET_CONTROLLER = "/tests"
DB_NAME = 'test2.db'

DATA_CARD_URL = "http://192.168.1.105:333"
VALUE_FILE_PATH = "test_arduino.txt"

GREENHOUSE_SERIAL_NBR =	'azer'
CONTROL_CARD_SERIAL_NBR = 'qsdf'
DATA_CARD_SERIAL_NBR = ['wxcv']

WEBCAM_PATH = '/dev/video0'
NB_PICS_TO_SKIP = 5
PIC_PATH = "/home/pi/Documents/Puissance3/pictures/"
WEBCAM_COMMAND = "fswebcam -d #{WEBCAM_PATH} -s brightness=60% -s Contrast=15% -s Gamma=50% -p YUYV -r 1280x720 --jpeg 80 -s Sharpness=40% -s Saturation=15%  -S #{NB_PICS_TO_SKIP} --png --save #{PIC_PATH}"
