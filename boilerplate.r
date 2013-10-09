# Check that the database file is there.
if (!(file.exists('treasury_data.db'))) {
  print('You need to download the database; run this.')
  print('  wget http://api.treasury.io/cc7znvq/47d80ae900e04f2/http/treasury_data.db')
  quit()
}

# Load dependencies
for (.library in c('ggplot2','sqldf')) {
  if (!(require(.library))) {
    install.packages(.library)
    library(.library)
  }
}
