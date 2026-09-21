CREATE INDEX idx_hotel_bookings_city_created_org_status_amount
ON hotel_bookings (city, created_at)
INCLUDE (org_id, status, amount);