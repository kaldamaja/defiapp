
		$(document).on('click',".comment-heart", function(){
			var comment_id = $(this).data("id");


			$.ajax({
				url: "/comment/heart/"+comment_id,
				method: "GET"
			}).done(function(response){
				console.log(response);
			})
		});



