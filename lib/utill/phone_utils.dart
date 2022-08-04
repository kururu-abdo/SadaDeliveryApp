class PhoneNumberUtils {
  



 static String  getPhoneNumberFromInputs(String phone) {
  if(phone.startsWith('05')) {
      var newPhone = phone.substring(1);

     return newPhone;
   }else {

     return phone;

   
   }

  }
}