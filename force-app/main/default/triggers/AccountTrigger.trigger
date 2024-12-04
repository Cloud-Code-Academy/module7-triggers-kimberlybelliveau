trigger AccountTrigger on Account (before insert, after insert) {
    if (Trigger.isBefore && Trigger.isInsert){
        for(Account acc : Trigger.New){
            if(String.isBlank(acc.Type)){
                acc.Type = 'Prospect';
            }
    
            if(!String.isBlank(acc.ShippingStreet) && !String.isBlank(acc.ShippingCity) && !String.isBlank(acc.ShippingState) && !String.isBlank(acc.ShippingPostalCode) && !String.isBlank(acc.ShippingCountry)){
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }

            if(!String.isBlank(acc.Phone) && !String.isBlank(acc.Website) && !String.isBlank(acc.Fax)){
                acc.Rating = 'Hot';
            }
        }
    }

    if (Trigger.isAfter && Trigger.isInsert){
        List<Contact> contactsToInsert = new List<Contact>();
        for(Account acc : Trigger.New){
            Contact newContact = new Contact (
                LastName = 'DefaultContact',
                Email = 'default@email.com',
                AccountId = acc.Id
            );
            contactsToInsert.add(newContact);
        }
        if(!contactsToInsert.isEmpty()){
            insert contactsToInsert;
        }
    }
}



