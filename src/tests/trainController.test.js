import app from '../index.js';
import request from 'supertest';
import jwt from "jsonwebtoken";

describe ("Train Controller", () => {
    describe("Get Stations Function", () => {

        const stationApi = "/api/trains/stations"
        test("should return a list of stations more than 400", async () => {
            const res = await request(app).get(stationApi)
            expect(res.body.length).toBeGreaterThan(400)
        })
    })

    describe ("Get Train Stops Function",  () => {
        const trainStopsApi = "/api/trains/admin/train-stations"
        // Generate a test JWT token with a known payload
        const payload = { username: 'movin@gmail.com' };
        const testToken = jwt.sign(payload, process.env.JWT_SECRET_ADMIN);
        
        test("should return a list of train stops", async () => {


            const res = await request(app).get(trainStopsApi)
            .set('Cookie', [`jwt_admin=${testToken}`])
            .query({page: 0, pageSize: 25, sort: '', search: ''});

            expect(res.body.trainstops.length).toBeGreaterThan(20)
        })

        test("should return the total with the list", async () => {

            const res = await request(app).get(trainStopsApi)
            .set('Cookie', [`jwt_admin=${testToken}`])
            .query({page: 0, pageSize: 25, sort: '', search: ''});

            expect(res.body.total).toBeDefined()
        })

        test("should return data in a single element in list", async () => {

            const res = await request(app).get(trainStopsApi)
            .set('Cookie', [`jwt_admin=${testToken}`])
            .query({page: 0, pageSize: 25, sort: '', search: ''});

            expect(res.body.trainstops[0].TrainNo).toBeDefined()
            expect(res.body.trainstops[0].stopID).toBeDefined()
            expect(res.body.trainstops[0].StationID).toBeDefined()
            expect(res.body.trainstops[0].ArrivalTime).toBeDefined()
        })

        
        describe("Checking the parametres passed", () => {

            test("should return the elements in the list to be pagesize passed", async () => {

                const res = await request(app).get(trainStopsApi)
                .set('Cookie', [`jwt_admin=${testToken}`])
                .query({page: 0, pageSize: 15, sort: '', search: ''});
    
                expect(res.body.trainstops.length).toBe(15)
            })
    
            test("should return the remaining elements in the list when page is passed", async () => {
    
                const res = await request(app).get(trainStopsApi)
                .set('Cookie', [`jwt_admin=${testToken}`])
                .query({page: 2, pageSize: 15, sort: '', search: ''});
    
                expect(res.body.trainstops.length).toBeGreaterThan(0)
            })
    
            test("should return nothing when unavailable string is passed to search parameter", async () => {
    
                const res = await request(app).get(trainStopsApi)
                .set('Cookie', [`jwt_admin=${testToken}`])
                .query({page: 0, pageSize: 25, sort: '', search: 'hfkshviwhevwkv'});
    
                expect(res.body.trainstops.length).toBe(0)
            })
            
        })

        test("should generate an error when jwt is not passed", async () => {
            const res = await request(app).get(trainStopsApi)
            .query({page: 0, pageSize: 25, sort: '', search: ''});
            expect(res.statusCode).toBe(401);
        })
    })
})