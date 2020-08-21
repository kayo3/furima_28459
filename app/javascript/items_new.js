$(function(){
  $('#item-price').on('input', function(){   //リアルタイム表示の為、入力の度にイベント発火するinputを使う｡
    var priceCalc = $('#item-price').val();  //val()でフォームのvalueを取得(数値)
    var fee = Math.floor(priceCalc * 0.1).toLocaleString();     //入力した数値の1/10が手数料｡
    var profit = Math.floor(priceCalc * 0.9).toLocaleString();  //販売利益。Math.floorで小数点切り捨て。.toLocaleString();で３桁区切り。
    $('#add-tax-price').html(fee)            //手数料の表示｡html()は追加ではなく､上書き｡入力値が変わる度に表示も変わる｡
    $('#profit').html(profit)                //販売利益の表示｡
  });
});