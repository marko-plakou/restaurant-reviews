package reviews;



public class Reviews {
	private String user;
	private String restaurant;
	private int stars_review;
	private String comment_review;
	
	
	public Reviews(String user,String restaurant,int stars_review) {
	this.user=user;
	this.restaurant=restaurant;
	this.stars_review=stars_review;
		
	}
	
	public String getUser() {return user;}
	public String getRestaurant() {return restaurant;}
	public int getStars() {return stars_review;}
	public String getComment() {return comment_review;}
	public void setComment(String comment) {
		this.comment_review=comment;
	}
}
