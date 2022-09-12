import importlib

print("I-Steal.py la odiasella! allora um...")

while True:
	ISBN = input("metti l'ISBN del libro che vuoi scaricare che magari ce l'ho: ")
	if(ISBN.isnumeric() and (len(ISBN) == 13 or len(ISBN) == 10)):
		break
	else:
		print("questo è un codice ISBN? non so io")

# cerca il modulo esatto per fare la ENNE
try:
	book = importlib.import_module("book." + ISBN)
except ModuleNotFoundError:
	print("non c'è il libro mi disp")
	quit()

# Scarica le pagine
book.download("./download")

# Convertile in PDF
# domani
