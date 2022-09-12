import requests

base_link = "https://d38l3k3yaet8r2.cloudfront.net/resources/products/epubs/generated/EBA38F30-D086-459C-9133-E557041B0E46/foxit-assets/pages/"

pages = 674

link_args = "password=&accessToken=null&formMode=true"

def get_page(i, path):
	print("scaricando pagina " + str(i) + "...")

	req = requests.get(base_link + "page" + str(i) + "?" + link_args)

	with open(path + "/page-" + str(i) + ".png", "wb") as img:
		img.write(req.content)

	print("pagina " + str(i) + " scaricata.")

def download(path):
	for i in range(pages):
		get_page(i, path)

