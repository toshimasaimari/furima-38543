window.addEventListener('load', function(){
  const productCost = document.getElementById("item-price")
  productCost.addEventListener('input', function(){
    const productTaxCost = document.getElementById("add-tax-price")
    productTaxCost.innerHTML = Math.floor(productCost.value * 0.1 )
    const productTaxFree = document.getElementById("profit")
    productTaxFree.innerHTML = Math.floor(productCost.value - Math.floor(productCost.value * 0.1 ))
  })
  })