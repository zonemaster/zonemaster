jQuery(function(){

	function remove_popups(){
		jQuery('#wait_animation').hide();
		jQuery('#displayed_text').html('');
		jQuery('#displayed_report').hide();
		jQuery('#progress_bar').val(0);
		jQuery('#progress_bar_label').html('');
		jQuery('#progress_bar_container').hide();
		jQuery('#processed_test_id').val('');
	}

	function retrieve_report(){
		jQuery('#displayed_text').html('');
		jQuery('#displayed_report').hide();
		jQuery('#wait_animation').hide();
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'retrieve_report',session_uuid:jQuery.trim(jQuery('#session_uuid').val()),
					"function":jQuery.trim(jQuery('#current_function').val()),
					testing_id:jQuery('#processed_test_id').val(),
					language:jQuery.trim(jQuery('#session_language').val())},
				dataType:'html',
				beforeSend: function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					jQuery('#displayed_text').html(data);
					jQuery('#displayed_report').show();
				})
				.fail(function(jqXHR, textStatus){
					remove_popups();
					jQuery('#error_message').html(jqXHR.responseText);
					jQuery('#error_message').show();
				});
	}

	function check_test_progress(){
		jQuery('#displayed_text').html('');
		jQuery('#displayed_report').hide();
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'verify_progress',session_uuid:jQuery.trim(jQuery('#session_uuid').val()),
					"function":jQuery.trim(jQuery('#current_function').val()),
					testing_id:jQuery('#processed_test_id').val(),
					language:jQuery.trim(jQuery('#session_language').val())},
				dataType:'json'
				})
				.done(function(data){
					jQuery('#progress_bar').val(data.message);
					jQuery('#processed_test_id').val(data.test_id);
					jQuery('#progress_bar_container').show();
					if(data.message == '100'){
						jQuery('#progress_bar').val('0');
						jQuery('#processed_test_id').val(data.test_id);
						jQuery('#progress_bar_container').hide();
						retrieve_report();
					}
					else
						setTimeout(check_test_progress, 2000);
				})
				.fail(function(jqXHR, textStatus){
					remove_popups();
					jQuery('#error_message').html(jqXHR.responseText);
					jQuery('#error_message').show();
				});
	}

	var local_cgi_prefix = jQuery.trim(jQuery('#local_cgi_url').val());
	var uuid = jQuery.trim(jQuery('#session_uuid').val());
	var language = jQuery.trim(jQuery('#session_language').val());
	var current_function = jQuery.trim(jQuery('#current_function').val());
	if(current_function.length==0){
		current_function='delegated_domains';
		jQuery('#current_function').val(current_function);
	}
	jQuery('#error_message').html('');
	jQuery('#error_message').hide();
	jQuery('#wait_animation').hide();
	if(uuid.length == 0){
		var user_info = document.cookie;
		if(user_info.length != 0){
			var cookies = user_info.match(/uuid=[a-z0-9\-]+/);	
			if(cookies[0].length != 0)
				uuid = cookies[0].replace('uuid=', '');
		}
		if(uuid.length == 0){
			var date = new Date();
			var expired_days = 30;
			date.setTime(date.getTime() + expired_days * 86400000); // expired in expired_days
			jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'register',language:navigator.language,"function":current_function},
				dataType:'json',
				beforeSend: function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					jQuery('#session_uuid').val(data.uuid);
					jQuery('#session_language').val(data.language);
					if(navigator.cookieEnabled)
				document.cookie = 'uuid=' + data.uuid + '; expires=' + date.toUTCString() + ';';
					else
				window.location = local_cgi_prefix + '/index.cgi/' + data.uuid + '/';
				})
				.fail(function(){
					jQuery('#wait_animation').hide();
					jQuery('#error_message').html('Failed to contact local server.');
					jQuery('#error_message').show();
				});
		}
		else{
			jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'retrieve',session_uuid:uuid,"function":current_function,
					language:navigator.language,},
				dataType:'json',
				beforeSend : function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					jQuery('#session_uuid').val(data.uuid);
					jQuery('#session_language').val(data.language);
				})
				.fail(function(){
					jQuery('#wait_animation').hide();
					jQuery('#error_message').html('Failed to contact local server.');
					jQuery('#error_message').show();
				});

		}
	}
	var preseting_test_id = jQuery.trim(jQuery('#preseting_test_id').val());
	if(preseting_test_id.length != 0){
		jQuery('#displayed_text').html('');
		jQuery('#displayed_report').hide();
		jQuery.ajax({type:'POST',
			url:local_cgi_prefix + '/session.cgi',
			data:{action:'retrieve_report',session_uuid:uuid,
				"function":current_function,
				testing_id:preseting_test_id,
				language:language},
				dataType:'html',
			beforeSend: function(){ jQuery('#wait_animation').show(); }
			})
			.done(function(data){
				jQuery('#wait_animation').hide();
				jQuery('#displayed_text').html(data);
				jQuery('#displayed_report').show();
				jQuery('#results_anchor').click();
			})
			.fail(function(jqXHR, textStatus){
				jQuery('#wait_animation').hide();
				jQuery('#displayed_text').html('');
				jQuery('#displayed_report').hide();
				jQuery('#error_message').html(jqXHR.responseText);
				jQuery('#error_message').show();
			});
	}	
	jQuery('.hide_report').on('click', function(){ jQuery('#displayed_report').hide()});

	jQuery('.cleanup_ns_ip_pair').on('click', function(){
		var id = this.id.replace('cleanup_ns_ip_', '');
		jQuery('#ns_value' + id).val('');
		jQuery('#ip_value' + id).val('');
		jQuery('#ns_ip_pair' + id).hide();
		for(var k = 30; k > 0; k--){
			var j = k - 1;
			if((jQuery('#ns_ip_pair' + j).css('display') != 'none') && 
				(jQuery('#ns_ip_pair' + k).css('display') == 'none')){
				jQuery('#ns_value' + k).val(jQuery.trim(jQuery('#ns_value' + j).val()));
				jQuery('#ip_value' + k).val(jQuery.trim(jQuery('#ip_value' + j).val()));
				jQuery('#ns_value' + j).val('');
				jQuery('#ip_value' + j).val('');
				jQuery('#ns_ip_pair' + k).show();
				jQuery('#ns_ip_pair' + j).hide();
			}
		}
	});
	jQuery('.language_selector').on('click', function(){
		var clicked_element = jQuery('#' + this.id);
		jQuery('.language_selector').each(function(){
			jQuery('#' + this.id).removeAttr('style'); 
		});	
		clicked_element.css('color','#bb3300'); 
		clicked_element.css('font-weight', 'bold');
		var clicked_language = '';
		if(clicked_element.attr('id') == 'french_selector')
			clicked_language = 'fr';
		else if(clicked_element.attr('id') == 'swedish_selector')
			clicked_language = 'sv';
		else
			clicked_language = 'en_US';
		var curr_function = jQuery.trim(jQuery('#current_function').val());
		if(curr_function.length==0){
			curr_function='delegated_domains';
			jQuery('#current_function').val(curr_function);
		}
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'modify',session_uuid:uuid,"function":curr_function,
					language:clicked_language},
				dataType:'json',
				beforeSend : function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					jQuery('#session_uuid').val(data.uuid);
					jQuery('#session_language').val(data.language);
					if(navigator.cookieEnabled)
						window.location = local_cgi_prefix + '/index.cgi';
					else
					window.location = local_cgi_prefix + '/index.cgi/' + data.uuid + '/';
				})
				.fail(function(){
					jQuery('#wait_animation').hide();
					jQuery('#error_message').html('Failed to contact local server.');
					jQuery('#error_message').show();
				});
		
	})
	jQuery('.selection_anchor').on('click', function(){
		var other_id = 'domain_test_anchor';
		if(this.id == 'domain_test_anchor'){
			other_id = 'undomain_test_anchor';
			jQuery('#current_function').val('delegated_domains');
		}
		else
			jQuery('#current_function').val('un_delegated_domains');
		var curr_function = jQuery.trim(jQuery('#current_function').val());

		jQuery('#' + this.id).css('z-index', '20');	
		jQuery('#' + this.id).css('background-color', '#f9f9f9');	
		jQuery('#' + other_id).css('z-index', '5');	
		jQuery('#' + other_id).css('background-color', '#c9c9c9');	
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'modify',session_uuid:jQuery.trim(jQuery('#session_uuid').val()),
					"function":curr_function,
					language:jQuery.trim(jQuery('#session_language').val())},
				dataType:'json',
				beforeSend : function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					jQuery('#session_uuid').val(data.uuid);
					jQuery('#session_language').val(data.language);
					if(navigator.cookieEnabled)
						window.location = local_cgi_prefix + '/index.cgi';
					else
					window.location = local_cgi_prefix + '/index.cgi/' + data.uuid + '/';
				})
				.fail(function(){
					jQuery('#wait_animation').hide();
					jQuery('#error_message').html('Failed to contact local server.');
					jQuery('#error_message').show();
				});
	});
	jQuery('#adv_options_check').on('click', function(){
		if(jQuery( this ).prop('checked')){
			['row_ipv4','row_ipv6','row_prof'].forEach(function(entry){
				jQuery('#' + entry).show();
			})
		}
		else{
			['row_ipv4','row_ipv6','row_prof'].forEach(function(entry){
				jQuery('#' + entry).hide();
			})
		}
	});
	jQuery('#ns_ip_add').on('click', function(){
		var count = 0;
		var hidden = 0;
		jQuery('.ns_ip_pair').each(function(){
			if(jQuery( this ).css('display') == 'none'){
				hidden++;
			}
			count++;
		});
		hidden--;
		if(hidden < 0)
			alert('Exceeded maximal amount of fields');
		else
			jQuery('#ns_ip_pair' + hidden).show();
	});
	jQuery('#ds_dig_add').on('click', function(){
		var count = 0;
		var hidden = 0;
		jQuery('.ds_dig_pair').each(function(){
			if(jQuery( this ).css('display') == 'none'){
				hidden++;
			}
			count++;
		});
		hidden--;
		if(hidden < 0)
			alert('Exceeded maximal amount of fields');
		else
			jQuery('#ds_dig_pair' + hidden).show();
	});
	jQuery('#submit_dns_test').on('click', function(){
		jQuery('#error_message').html('');
		jQuery('#error_message').hide();
		jQuery('#displayed_text').html('');
		jQuery('#displayed_report').hide();
		var domain_to_test = jQuery.trim(jQuery('#domaininput').val());
		if(domain_to_test.length == 0){
			alert(jQuery.trim(jQuery('#no_domain_supplied').val()));
			return true;
		}
		var posted_data = {action:'verify_domain',
					session_uuid:jQuery.trim(jQuery('#session_uuid').val()),
                                   	"function":jQuery.trim(jQuery('#current_function').val()),
                                        testing_domain:domain_to_test,
                                        language:jQuery.trim(jQuery('#session_language').val())};

		if(jQuery('#adv_options_check').prop('checked')){
			posted_data['adv_option'] = 1;
			posted_data['ipv4'] = jQuery('#test_ipv4').prop('checked') ? '1' : '0';
			posted_data['ipv6'] = jQuery('#test_ipv6').prop('checked') ? '1' : '0';
			posted_data['test_prof'] = jQuery('#profile_select').val();
		}
		if(jQuery('#current_function').val() == 'un_delegated_domains'){
					posted_data['ns_ip_pairs'] = [];
					posted_data['ds_dig_pairs'] = [];
               				jQuery('.ns_ip_pair').each(function(){
                        			if(jQuery( this ).css('display') != 'none'){
							var field_index = this.id.match(/[0-9]+/);
							if(field_index == null){
								var ns_value = jQuery.trim(jQuery('#ns_value').val());
								var ip_value = jQuery.trim(jQuery('#ip_value').val());
								if((ns_value.length > 0) && (ip_value.length > 0))
						posted_data['ns_ip_pairs'].push({"ns":ns_value,"ip":ip_value});
                        				}
							else{
						var ns_value = jQuery.trim(jQuery('#ns_value' + field_index[0]).val());
						var ip_value = jQuery.trim(jQuery('#ip_value' + field_index[0]).val());
								if((ns_value.length > 0) && (ip_value.length > 0))
						posted_data['ns_ip_pairs'].push({"ns":ns_value,"ip":ip_value});
							}
						}
                			});
					if(posted_data['ns_ip_pairs'].length == 0){
						alert(jQuery.trim(jQuery('#no_pairs_supplied').val()));
						return;
					}
					jQuery('.ds_dig_pair').each(function(){
						if(jQuery( this ).css('display') != 'none'){
							var field_index = this.id.match(/[0-9]+/);
							if(field_index == null){
								var ds_value = jQuery.trim(jQuery('#ds_value').val());
								var dig_value = jQuery.trim(jQuery('#dig_value').val());
								if((ds_value.length > 0) && (dig_value.length > 0))
						posted_data['ds_dig_pairs'].push({"ds":ds_value,"dig":dig_value});
                        				}
							else{
						var ds_value = jQuery.trim(jQuery('#ds_value' + field_index[0]).val());
						var dig_value = jQuery.trim(jQuery('#dig_value' + field_index[0]).val());
								if((ds_value.length > 0) && (dig_value.length > 0))
						posted_data['ds_dig_pairs'].push({"ds":ds_value,"dig":dig_value});
							}
						}
					});

		}
		jQuery('#progress_bar').val(0);
		jQuery('#progress_bar_label').html('');
		jQuery('#processed_test_id').val('');
		jQuery('#progress_bar_container').hide();
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:posted_data,
				dataType:'json',
				beforeSend: function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					jQuery('#progress_bar').val(0);
					jQuery('#progress_bar_label').html(data.message);
					jQuery('#processed_test_id').val(data.test_id);
					jQuery('#progress_bar_container').show();
					setTimeout(check_test_progress, 2000);
				})
				.fail(function(jqXHR, textStatus){
					remove_popups();
					jQuery('#error_message').html(jqXHR.responseText);
					jQuery('#error_message').show();
				});
	});
	jQuery('#fetch_from_parent').on('click', function(){
		var domain_input = jQuery.trim(jQuery('#domaininput').val());
		if(domain_input.length == 0){
			alert(jQuery.trim(jQuery('#no_domain_supplied').val()));
			return;
		}
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'fetch_from_parent',session_uuid:jQuery.trim(jQuery('#session_uuid').val()),
					"function":jQuery.trim(jQuery('#current_function').val()),
					domain:domain_input,
					language:jQuery.trim(jQuery('#session_language').val())},
				dataType:'json',
				beforeSend: function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					for(var i = 0; i< 30; i++){
						jQuery('#ns_value' + i).val('');
						jQuery('#ip_value' + i).val('');
						jQuery('#ns_ip_pair' + i).hide();
					}
					var hidden = 0;
               				jQuery('.ns_ip_pair').each(function(){
                        			if(jQuery( this ).css('display') == 'none'){
                               				 hidden++;
                        			}
                			});
                			if(hidden < data.length){
                        			alert('Exceeded maximal amount of fields');
						return;
					}
					for(var k = 0; k< data.length; k++){
						var entry = data[k];
						for(var key in entry){
							jQuery('#ns_ip_pair' + hidden).show('');
							jQuery('#ns_value' + hidden).val(key);
							jQuery('#ip_value' + hidden).val(entry[key]);
							hidden--;
						}
					}
				})
				.fail(function(jqXHR, textStatus){
					jQuery('#wait_animation').hide();
					jQuery('#error_message').html(jqXHR.responseText);
					jQuery('#error_message').show();
				});
		
	});

	jQuery('.ns_value_field').on('change', function(){
		var nameserver = jQuery.trim(jQuery( this ).val());
		var field_id = this.id;
		jQuery('#error_message').html('');
		jQuery('#error_message').hide();
		if(nameserver.length == 0)
			return;
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'nameserver_ips',session_uuid:jQuery.trim(jQuery('#session_uuid').val()),
					"function":jQuery.trim(jQuery('#current_function').val()),
					nameserver:nameserver,
					language:jQuery.trim(jQuery('#session_language').val())},
				dataType:'json',
				beforeSend: function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					if(data.length == 0){
						alert('No valid ip addresses detected for: ' + nameserver);
						jQuery('#' + field_id).val('');
						return;
					}
					var hidden = 0;
               				jQuery('.ns_ip_pair').each(function(){
                        			if(jQuery( this ).css('display') == 'none'){
                               				 hidden++;
                        			}
                			});
					var field_index = field_id.match(/[0-9]+/);
					if(field_index == null)
                				hidden--;
                			if(hidden < data.length){
                        			alert('Exceeded maximal amount of fields');
						jQuery('#' + field_id).val('');
						return;
					}
					for(var k = 0; k < data.length; k++){
						jQuery('#ns_ip_pair' + hidden).show('');
						jQuery('#ns_value' + hidden).val(nameserver);
						jQuery('#ip_value' + hidden).val(data[k]);
						hidden--;
					}
					if(field_index == null)
						jQuery('#' + field_id).val('');
				})
				.fail(function(jqXHR, textStatus){
					jQuery('#wait_animation').hide();
					jQuery('#error_message').html(jqXHR.responseText);
					jQuery('#error_message').show();
				});
	});
	jQuery('#home_anchor').on('click', function(){
		jQuery('#domain_test_anchor').click();
	});
	jQuery('#undelegated_anchor').on('click', function(){
		jQuery('#undomain_test_anchor').click();
	});
	jQuery('#faq_anchor').on('click', function(){
		jQuery('#displayed_text').html('');
		jQuery('#displayed_report').hide();
		jQuery('#wait_animation').hide();
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'retrieve_faq',session_uuid:jQuery.trim(jQuery('#session_uuid').val()),
					"function":jQuery.trim(jQuery('#current_function').val()),
					language:jQuery.trim(jQuery('#session_language').val())},
				dataType:'html',
				beforeSend: function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					jQuery('#displayed_text').html(data);
					jQuery('#displayed_report').show();
				})
				.fail(function(jqXHR, textStatus){
					remove_popups();
					jQuery('#error_message').html(jqXHR.responseText);
					jQuery('#error_message').show();
				});
	});
	jQuery('#about_anchor').on('click', function(){
		jQuery('#displayed_text').html('');
		jQuery('#displayed_report').hide();
		jQuery('#wait_animation').hide();
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'retrieve_about',session_uuid:jQuery.trim(jQuery('#session_uuid').val()),
					"function":jQuery.trim(jQuery('#current_function').val()),
					language:jQuery.trim(jQuery('#session_language').val())},
				dataType:'html',
				beforeSend: function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					jQuery('#displayed_text').html(data);
					jQuery('#displayed_report').show();
				})
				.fail(function(jqXHR, textStatus){
					remove_popups();
					jQuery('#error_message').html(jqXHR.responseText);
					jQuery('#error_message').show();
				});
	});
	jQuery('#results_anchor').on('click', function(){
		var domain_input = jQuery.trim(jQuery('#domaininput').val());
		if(domain_input.length == 0){
			alert(jQuery.trim(jQuery('#no_domain_supplied').val()));
			return;
		}
		jQuery('#displayed_history_text').html('');
		jQuery('#displayed_history').hide();
		jQuery.ajax({type:'POST',
				url:local_cgi_prefix + '/session.cgi',
				data:{action:'fetch_test_history',session_uuid:jQuery.trim(jQuery('#session_uuid').val()),
					"function":jQuery.trim(jQuery('#current_function').val()),
					domain:domain_input,
					language:jQuery.trim(jQuery('#session_language').val())},
				dataType:'html',
				beforeSend: function(){ jQuery('#wait_animation').show(); }
				})
				.done(function(data){
					jQuery('#wait_animation').hide();
					jQuery('#displayed_history_text').html(data);
					jQuery('#displayed_history').show();
				})
				.fail(function(jqXHR, textStatus){
					remove_popups();
					jQuery('#displayed_history_text').html('');
					jQuery('#displayed_history').hide();
					jQuery('#error_message').html(jqXHR.responseText);
					jQuery('#error_message').show();
				});
	});
});
