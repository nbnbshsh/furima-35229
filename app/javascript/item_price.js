 function tax() {
  const priceInput = document.getElementById("item-price");
  if(!priceInput){return false;}
  priceInput.addEventListener('input', () => {
    const price = priceInput.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit =document.getElementById("profit");
    const taxPrice = Math.floor(price * 0.1);

    const saleProfit=price-taxPrice;
    addTaxPrice.innerHTML = taxPrice;
    profit.innerHTML=saleProfit;
  });

 }
window.addEventListener('load',tax);