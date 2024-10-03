package com.synergysoft.bonvoyage.common;

public class Place implements java.io.Serializable {

	private static final long serialVersionUID = 8072654861485651643L;
	
	private String placeId; 		// PLACE_ID	VARCHAR2(255 BYTE)
	private String placeName; // PLACE_NAME	VARCHAR2(255 BYTE)
	private String address;		// ADDRESS	VARCHAR2(255 BYTE)
	private int latitude;		// LATITUDE	NUMBER
	private int longitude;		// LONGITUDE	NUMBER
	
	public Place() {
		super();
	}

	public Place(String placeId, String placeName, String address, int latitude, int longitude) {
		super();
		this.placeId = placeId;
		this.placeName = placeName;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public String getPlaceId() {
		return placeId;
	}

	public void setPlaceId(String placeId) {
		this.placeId = placeId;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getLatitude() {
		return latitude;
	}

	public void setLatitude(int latitude) {
		this.latitude = latitude;
	}

	public int getLongitude() {
		return longitude;
	}

	public void setLongitude(int longitude) {
		this.longitude = longitude;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Place [placeId=" + placeId + ", placeName=" + placeName + ", address=" + address + ", latitude="
				+ latitude + ", longitude=" + longitude + "]";
	}
	
	
}
