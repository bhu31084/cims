<%@ page import="in.co.paramatrix.common.authz.AuthZ"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%

	String role_name = request.getParameter("role");
	
	AuthZ authz = AuthZ.getInstance();
	
	if(request.getParameter("entities") != null){
	
		String entity_names = request.getParameter("entities");
		if(entity_names.trim().length() > 0){
			Boolean isMap = new Boolean(request.getParameter("isMap"));
			Boolean isUser = new Boolean(request.getParameter("isUser"));
			
			String[] arrEntityNames = entity_names.split(",");
			Vector<String> vEntityNames = new Vector<String>();
			
			for(String entity_name : arrEntityNames){
				vEntityNames.add(entity_name);
			}
			try{
				if(isUser){
					if(isMap) {
						authz.mapUsersToRole(role_name, vEntityNames);
					} else {
						authz.unmapUsersFromRole(role_name, vEntityNames);
					}
				}else{
					if(isMap) {
						authz.addOpsToRole(vEntityNames, role_name);
					} else {
						authz.removeOpsFromRole(vEntityNames, role_name);
					}		
				}
			}catch(Exception e){
				System.err.println(e);	
			}
		}
	}
	
	
	Vector<String> vAuthOps = new Vector<String>();
	Vector<String> vAllOps = new Vector<String>();
	
	Vector<String> vAuthUsers = new Vector<String>();
	Vector<String> vAllUsers = new Vector<String>();
	
	try{
		vAuthOps = authz.getOpsForRole(role_name);
	}catch(Exception e){
		System.out.println(e);
	}
	try{
		vAllOps = authz.getAllOps();
	}catch(Exception e){
		System.out.println(e);
	}
	try{
		vAuthUsers = authz.getUsersForRole(role_name);
	}catch(Exception e){
		System.out.println(e);
	}
	
	try{
		vAllUsers = authz.searchUsers("");
	}catch(Exception e){
		System.out.println(e);
	}
	

	StringBuffer sbAuthOp = new StringBuffer();
	StringBuffer sbNonauthOp = new StringBuffer();
	StringBuffer sbauthUsers = new StringBuffer();
	StringBuffer sbunauthUsers = new StringBuffer();
	
	for(String op : vAllOps){
		if(!vAuthOps.contains(op.trim())){
			sbNonauthOp.append(op.trim().toLowerCase() + ",");
		}else{
			sbAuthOp.append(op.trim().toLowerCase() + ",");
		}
	}
		
	for(String user : vAllUsers){
		if(!vAuthUsers.contains(user)){
			sbunauthUsers.append(user.trim().toLowerCase() + ',');
		}else{
			sbauthUsers.append(user.trim().toLowerCase() + ',');
		}
	}

	if(sbNonauthOp.length() > 1){
		sbNonauthOp.delete(sbNonauthOp.length() - 1, sbNonauthOp.length());
	}
	if(sbAuthOp.length() > 1){
		sbAuthOp.delete(sbAuthOp.length() - 1, sbAuthOp.length());
	}	
	if(sbauthUsers.length() > 1){
		sbauthUsers.delete(sbauthUsers.length() - 1, sbauthUsers.length());
	}
	if(sbunauthUsers.length() > 1){
		sbunauthUsers.delete(sbunauthUsers.length() - 1, sbunauthUsers.length());
	}
%>

<%=sbAuthOp.toString() + "|" + sbNonauthOp.toString() + "|" + sbauthUsers.toString() + "|" + sbunauthUsers.toString() %>