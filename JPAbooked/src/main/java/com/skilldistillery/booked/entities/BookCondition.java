package com.skilldistillery.booked.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class BookCondition {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String name;
	@Column(name="condition_desc")
	private String conditionDescription;
	
	public BookCondition() {}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getConditionDescription() {
		return conditionDescription;
	}
	public void setConditionDescription(String conditionDescription) {
		this.conditionDescription = conditionDescription;
	}
	@Override
	public int hashCode() {
		return Objects.hash(conditionDescription, name);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookCondition other = (BookCondition) obj;
		return Objects.equals(conditionDescription, other.conditionDescription) && Objects.equals(name, other.name);
	}
	@Override
	public String toString() {
		return "BookCondition [name=" + name + ", conditionDescription=" + conditionDescription + "]";
	}
	
	
}
