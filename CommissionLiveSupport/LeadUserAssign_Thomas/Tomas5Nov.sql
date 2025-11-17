		
		select * from Users where id = 1094
		select * from UserRoles where id = 61;


			Select Id LeadId, Leadrefno into #TomasLead4nov from quotation.leads where id in (
			879,1671,1813,2205,8681,9218,10880,11261,13720,
14043,14163,14175,14242,14414,14539,14549,14586,14608,14609,14620,14638,14664,14758,14784,
14812,14825,15043,15076,15081,15208,15238,15245,15253,15257,15282,15286,
15292,15484,15519,15522,15536,15563,15564,15636,15641,15657,15664,15672,15680,15738,15761,15788,15880,
15886,15907,15935,16061,16118,16166,16225,16332,16365,16401,16408,16426,16432,16466,
16593,16697,16703,16711,16714,16716,16718,16733,16739,16763,16778,16813,17011,17761
)


select * from commission.leadusercommissions where fkuserId = 1094;

DECLARE @userId int = 1094
DECLARE @LeadId INT;
Declare @RoleId int = 61; 

 Select #TomasLead4nov.LeadId from #TomasLead4nov where #TomasLead4nov.LeadId not in (
  select FkLeadId from  quotation.LeadAssignedUsers where  FkAssignedUserId = @userId and fkroleid = @RoleId )

DECLARE lead_cursor CURSOR FOR

 Select #TomasLead4nov.LeadId from #TomasLead4nov where #TomasLead4nov.LeadId not in (
  select FkLeadId from  quotation.LeadAssignedUsers where  FkAssignedUserId = @userId and fkroleid = @RoleId )

OPEN lead_cursor;
FETCH NEXT FROM lead_cursor INTO @LeadId;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO quotation.LeadAssignedUsers (
        FkLeadId,
        FkAssignedUserId,
        FkRoleId,
        CreatedBy,
        CreatedDate,
        RStatus
    )
    VALUES (
        @LeadId,
        @userId,       -- Sales Director ID
        @RoleId,       -- Role ID
        1,        -- CreatedBy (System Admin or Migration User)
        GETDATE(),
        1         -- Active
    );

    FETCH NEXT FROM lead_cursor INTO @LeadId;
END;

CLOSE lead_cursor;
DEALLOCATE lead_cursor;



DECLARE @userId int = 1094;
Update commission.LeadUserCommissions  set FkUserId = @userId, UpdatedDate = getdate()
where FkUserId is null 
and FkLeadId in (select leadid from #TomasLead4nov) and rstatus = 1 and FkRoleId = 61  and FkCommissionItemId in (54,55)