# running superset image without changing SECRET_KEY raise the following error:

# A Default SECRET_KEY was detected, please use superset_config.py to override it.
# Use a strong complex alphanumeric string and use a tool to help you generate 
# a sufficiently random sequence

FEATURE_FLAGS = {
	    "ENABLE_TEMPLATE_PROCESSING": True,
	    "ALLOW_ADHOC_SUBQUERY": True
	}
	

ENABLE_PROXY_FIX = True

SECRET_KEY = "YOUR_OWN_RANDOM_GENERATED_STRING"

D3_FORMAT = {
  "decimal": ",",
  "thousands": "\u00a0",
  "grouping": [3],
  "currency": ["", "\u00a0\u20bd"],
  "dateTime": "%A, %e %B %Y г. %X",
  "date": "%d.%m.%Y",
  "time": "%H:%M:%S",
  "periods": ["AM", "PM"],
  "days": ["воскресенье", "понедельник", "вторник", "среда", "четверг", "пятница", "суббота"],
  "shortDays": ["вс", "пн", "вт", "ср", "чт", "пт", "сб"],
  "months": ["января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"],
  "shortMonths": ["янв", "фев", "мар", "апр", "май", "июн", "июл", "авг", "сен", "окт", "ноя", "дек"]
}

CURRENCIES = ["USD", "EUR", "GBP", "INR", "MXN", "JPY", "CNY", "RUB"]

SUPERSET_WEBSERVER_TIMEOUT = int(timedelta(minutes=2).total_seconds())
SQLLAB_TIMEOUT=120
