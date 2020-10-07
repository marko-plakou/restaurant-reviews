package restaurants;

import restaurant_owners.Restaurant_Owners;

public class Restaurant{
	private final String restaurantowner;
	private final String restaurant_name;
	private final String restaurant_type;
	private String restaurant_region;
	private String restaurant_telephone;
	private String restaurant_image_path;
	private boolean isActive=false;
	
	public Restaurant(String owner,String name,String type,String region,String telephone,String image_path){
		restaurantowner=owner;
		restaurant_name=name;
		restaurant_type=type;
		restaurant_region=region;
		restaurant_telephone=telephone;
		restaurant_image_path=image_path;
		
	}
	
	public String getRestaurantName() {
		return restaurant_name;
	}
	public String getRestaurantType() {
		return restaurant_type;
	}
	public String getRestaurantRegion() {
		return restaurant_region;
	}
	public String getRestaurantTelephone() {
		return restaurant_telephone;
	}
	public String getRestaurantOwner() {
		return restaurantowner;
	}
	public String getRestaurantImagePath() {
		return restaurant_image_path;
	}
	public boolean isRestaurantActive() {
		return isActive;
	}
	 

	


	
	
	
	

}
