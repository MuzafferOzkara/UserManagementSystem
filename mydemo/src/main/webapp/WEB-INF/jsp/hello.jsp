<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>

<!DOCTYPE html>
<html>
 
<head>


<!-- <meta  http-equiv="Content-Type" content="text/html; charset="UTF-8"> -->
<meta charset="UTF-8" http-equiv="Content-Type" content="text/html; charset=ISO-8859-9">
<title>Users</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.14.0/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.5.3/js/bootstrapValidator.js"></script>


</head>
<body onload="load();">




<button id="addFormButton" type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" style="margin-left:925px;
	margin-top:50px;"> Add User </button>


 		<div class="container" >
 		 <div class="form-group">	

     <div class="table-responsive">        	
 
        <table class='table' id="table" border=1 style="margin-top:50px;">
            <tr> <th> Ad </th> <th> Soyad </th> <th> Telefon </th><th> Edit </th> <th> Delete </th> </tr>
         
        </table>
        
        </div>       
        
        </div>   
        
        <script type="text/javascript">   

        data = "";

        $(document).ready(function(){        	 
        	
        	  $('#phoneNumber').mask('0000-000-00-00');

        		validform();       	 
        	  
        	});
       
        function submit(){
		
            

            if($('#firstName').val()=="" || $('#lastName').val()==""){
				validform();            	    


               
                }else{
              if($('#id').val()==""){
                  
                $.ajax({
                    url:'save',
                    type:'POST',

                    data: {firstName:$('#firstName').val(),lastName:$('#lastName').val(),phoneNumber:$('#phoneNumber').val()},
                    success: function(response){

                            load();   
                            console.log("save") 
                            console.log(id) ;
                            reset();                          
                          
                    }               
                });
                $('#exampleModalCenter').modal('toggle');   
              }else{
            		$('#exampleModalCenter').modal('toggle');
            	  $.ajax({
                      url:'updateUser',
                      type:'POST',
                      id:$("#id").val(),
                      data: {id:$("#id").val(),firstName:$('#firstName').val(),lastName:$('#lastName').val(),phoneNumber:$('#phoneNumber').val()},
                      success: function(response){

                              load();  
                              console.log("update");
                              console.log(id) ;
                              reset();
                              
                      }               
                  });     

                  }    

                     }


                }
            


      function delete_(index){
    	  $('#exampleModal').modal('toggle');   
         var x=$("#id").val();
         console.log(x);
          var y=$("#firstName").val();
         var z=$("#lastName").val();
          var t=$("#phoneNumber").val()

            
            console.log(id)   
             $.ajax({
                url:'deleteuser',
                type:'DELETE',
                data:{id:x,firstName:y,lastName:z,phoneNumber:t},
                success: function(response){
//                         alert(response.message);
                        load();
                        
                }               
            });
    }
         
     
        function edit(index){
            $("#id").val(data[index].id);
            $("#firstName").val(data[index].firstName);
            $("#lastName").val(data[index].lastName);
            $("#phoneNumber").val(data[index].phoneNumber);
             
        }
         
         
        function load(){  
            $.ajax({
                url:'list',
                type:'POST',
                success: function(response){
                        data = response.data;
                        $('.tr').remove();
                        for(i=0; i<response.data.length; i++){                   
                            $("#table").append("<tr class='tr'> <td> "+response.data[i].firstName+" </td> <td> "+response.data[i].lastName+" </td> <td> "+response.data[i].phoneNumber+" </td> <td> <a href='#' data-toggle='modal' data-target='#exampleModalCenter' onclick= edit("+i+");> Edit </a>  </td> </td> <td> <a href='#' data-toggle='modal' data-target='#exampleModal' onclick=edit("+i+");> Delete </a>  </td> </tr>");
                        }           
                }               
            });
             
        }

        function reset(){
            $("#id").val("");
            $("#firstName").val("");
            $("#lastName").val("");
            $("#phoneNumber").val("");
             
        }      


        function validform(){

        	 $("#saveForm").validate({
     		    rules: {
     		      firstName: {
     		        required: true,
     		        minlength: 3
     		      },
     		      lastName: {
     		        required: true,
     		        minlength: 3
     		      }
     		    },
     		    messages: {
     		      firstName: {
     		        required: "Please enter some data",
     		        minlength: "Your data must be at least 3 characters"
     		      },
     		      lastName: "Please provide some data"
     		    }
     		  });
         
            }


      
             

        </script>
             
     
<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">Add User</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
         <form  id="saveForm" data-toggle="validator" role="form" onsubmit="return false;">
         <div class="form-group">
         <input type="hidden" id="id" >
         </div>
         
         
         
          <div class="form-group">
            <label for="firstName" class="col-form-label">Ad:</label>
            <div>
             <input type="text" class="form-control" id="firstName" name="firstName"  placeholder="First Name" required>
            </div> 
             
          </div>
          
          <div class="form-group">
            <label for="lastName" class="col-form-label">Soyad:</label>
           <div>
            <input type="text" class="form-control" id="lastName"  name="lastName" placeholder="Last Name" required>
          </div>
          </div>
           <div class="form-group">
            <label for="phoneNumber" class="col-form-label">Telefon:</label>
            <input type="text" class="form-control" id="phoneNumber"  name="phoneNumber" >
          </div>
          <div class="g-recaptcha" data-sitekey="6LeVirwUAAAAALtus_-fJ5evFXSaRM3yVW9G97JJ"></div>
         
         
    
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        
     		 <button id="addUser" onclick="submit();" type="button" class="btn btn-primary">Save</button>
     		
<!--         <button id="addUser" onclick="submit();" type="submit" class="btn btn-primary">Kaydet</button> -->
      </div>
    </div>
  </div>
</div>
   
    
    
    
    
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
     
    
      <div class="modal-body">
       <div>
        Are you sure delete this user?
      </div>
        <input type="hidden" id="id" >
         <input type="hidden" id="firstName" >
          <input type="hidden" id="lastName" >
           <input type="hidden" id="phoneNumber" >
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="delete_(i);">Save changes</button>
      </div>
    </div>
  </div>
</div>
    
    
    
  
    
    
    
    
    
    
   
    
    
     
</body>


</html>