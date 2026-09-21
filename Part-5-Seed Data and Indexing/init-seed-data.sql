-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- -----------------------------------------------------------------------------
-- 1. SCHEMA DEFINITION
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS hotel_bookings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    org_id UUID NOT NULL,
    hotel_id VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS booking_events (
    id BIGSERIAL PRIMARY KEY,
    booking_id UUID NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    payload JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking
        FOREIGN KEY(booking_id) 
        REFERENCES hotel_bookings(id) 
        ON DELETE CASCADE
);

-- -----------------------------------------------------------------------------
-- 2. SEED DATA GENERATION (100+ Bookings & Events)
-- -----------------------------------------------------------------------------
DO $$
DECLARE
    -- Pre-defined Organization UUIDs
    org_1 UUID := 'a1111111-1111-1111-1111-111111111111';
    org_2 UUID := 'b2222222-2222-2222-2222-222222222222';
    org_3 UUID := 'c3333333-3333-3333-3333-333333333333';
    org_4 UUID := 'd4444444-4444-4444-4444-444444444444';
    
    cities TEXT[] := ARRAY['delhi', 'mumbai', 'bangalore', 'goa', 'delhi', 'hyderabad'];
    statuses TEXT[] := ARRAY['CONFIRMED', 'PENDING', 'CANCELLED', 'COMPLETED'];
    orgs UUID[] := ARRAY[org_1, org_2, org_3, org_4];
    
    i INT;
    new_booking_id UUID;
    chosen_city TEXT;
    chosen_status TEXT;
    chosen_org UUID;
    created_time TIMESTAMP;
BEGIN
    -- Generate 120 Hotel Bookings
    FOR i IN 1..120 LOOP
        new_booking_id := gen_random_uuid();
        chosen_city := cities[1 + floor(random() * array_length(cities, 1))];
        chosen_status := statuses[1 + floor(random() * array_length(statuses, 1))];
        chosen_org := orgs[1 + floor(random() * array_length(orgs, 1))];
        
        -- Distribute creation dates over the last 60 days
        created_time := NOW() - (random() * INTERVAL '60 days');

        INSERT INTO hotel_bookings (
            id, org_id, hotel_id, city, checkin_date, checkout_date, amount, status, created_at
        ) VALUES (
            new_booking_id,
            chosen_org,
            'HOTEL_' || lpad((floor(random() * 50) + 1)::text, 3, '0'),
            chosen_city,
            (created_time + INTERVAL '5 days')::date,
            (created_time + INTERVAL '8 days')::date,
            ROUND((random() * 450 + 50)::numeric, 2),
            chosen_status,
            created_time
        );

        -- Add events for roughly 60% of bookings
        IF random() > 0.4 THEN
            INSERT INTO booking_events (booking_id, event_type, payload, created_at)
            VALUES (
                new_booking_id,
                'BOOKING_CREATED',
                jsonb_build_object('source', 'web_app', 'ip', '192.168.1.' || (floor(random() * 254) + 1)::text),
                created_time
            );

            -- Add a second event (payment/cancellation) for a subset of those
            IF random() > 0.5 THEN
                INSERT INTO booking_events (booking_id, event_type, payload, created_at)
                VALUES (
                    new_booking_id,
                    CASE WHEN chosen_status = 'CANCELLED' THEN 'BOOKING_CANCELLED' ELSE 'PAYMENT_RECEIVED' END,
                    jsonb_build_object('gateway', 'stripe', 'transaction_id', 'tx_' || floor(random() * 1000000)::text),
                    created_time + INTERVAL '10 minutes'
                );
            END IF;
        END IF;

    END LOOP;
END $$;

-- Foreign key & secondary indexes
CREATE INDEX IF NOT EXISTS idx_booking_events_booking_id ON booking_events(booking_id);

-- -----------------------------------------------------------------------------
-- 3. OPTIMIZED INDEX FOR THE AGGREGATION QUERY
-- -----------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_hotel_bookings_city_created_org_status_amount
ON hotel_bookings (city, created_at)
INCLUDE (org_id, status, amount);