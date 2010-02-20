survey "Business Condition Review" do
  section "General" do    
    q "How clear are your company's policies defined?", :pick => :one
    a "The company's policies and objectives clearly defined and understood by all.", :short_text => :p
    a "The company's policies are not clearly defined and/or understood.", :short_text => :a
    a "The company does not currently have a general policy.", :short_text => :w

    q "What best describes the role of planning in your decision-making process?", :pick => :one
    a "All current and potential external economic factors recognized in overall company planning.", :short_text => :p
    a "Sporadic considerations or potential external economic factors in company planning.", :short_text => :a
    a "Planning is done under impulse and/or not performed at all.", :short_text => :w

    q "What best describes your attitude toward trade associations?", :pick => :one
    a "Aggressively participate in trade and business associations.", :short_text => :p
    a "Interested in trade and business, but don't actively participate.", :short_text => :a
    a "Trade and business associations are regarded as a necessary evil or otherwise unattended.", :short_text => :w

    q "What best describes your relationship with your government?", :pick => :one
    a "The company keeps currently informed on federal, state and local regulations.", :short_text => :p
    a "Government relationships are determined by legal counsel but not passed along to company executives.", :short_text => :a
    a "No policy on governmental matters; local government offices are called only when in doubt or in trouble.", :short_text => :w
  end

  section "Employees" do
    q "What best describes the company's industrial relations management policy?", :pick => :one
    a "One or more manager(s), vested with adequate authority, formulates sound industrial relations policies and represents the company in labor negotiations.", :short_text => :p
    a "The value of industrial regulations realized, but authority and responsibility not clearly defined; no movement toward change.", :short_text => :a
    a "The industrial relations function is one of employment only.", :short_text => :w

    q "What best describes your industrial relations program's plans?", :pick => :one
    a "An program that minimizes labor turnover, builds employee morale and efficiency.", :short_text => :p
    a "Industrial relations is not actively managed, but ably administered with employee morale and efficiency average.", :short_text => :a
    a "Little considerations is given to industrial relations; employee turnover high.", :short_text => :w

    q "What best describes your selection policy?", :pick => :one
    a "There is a program for effective selecting, testing, placing and training of all personnel.", :short_text => :p
    a "Employee selection not developed beyond office manager for clerical help and by department manager for all other help.", :short_text => :a
    a "The company has no uniform procedure for applicant screening, placement, and training. Original interviewing is left to each department head, little or no follow-up.", :short_text => :w

    q "What best describes your company's compensation packages?", :pick => :one
    a "Salary and wage rates are equitable and fair for each job classification from common labor to top management, established by sound job evaluation methods.", :short_text => :p
    a "The company has no job evaluation program; wage rates increased under pressure. Management and supervisory positions are awarded largely on basis of seniority.", :short_text => :a
    a "Job rates are fixed by personal opinion.", :short_text => :w

    q "What best describes your organization's incentive plans?", :pick => :one
    a "There are incentive plans for all levels of employees, based on equitable measurement of performance.", :short_text => :p
    a "Incentive plans are in place for some employees only.", :short_text => :a
    a "The company has no incentive plan.", :short_text => :w

    q "What best describes your records-keeping policy?", :pick => :one
    a "Individual history and progress records are maintained and kept up-to-date for every employee.", :short_text => :p
    a "Some records are maintained, but they are incomplete.", :short_text => :a
    a "No records are kept on individual employees beyond payroll requirements.", :short_text => :w
  end

  section "Finance" do
    q "What best describes your financial planning procedures?", :pick => :one
    a "A regular forecast of working capital and cash requirements for planned business volume and profits level is maintained.", :short_text => :p
    a "No regular forecast of working capital and/or cash requirements is produced; funds are not always obtained or employed.", :short_text => :a
    a "The company's working capital and cash are inadequate and/or credit policy is lax. Little or no forward planning exists.", :short_text => :w

    q "What best describes the state of your organization's cash reserves?", :pick => :one
    a "The organization has adequate reserves for replacement of obsolete and depreciating assets represented by earmarked liquid funds to the extent required.", :short_text => :p
    a "The organization maintains depreciation reserves conditioned on allowable deductions for tax purposes only; not properly planned from a capital asset replacement point-of-view.", :short_text => :a
    a "The organization has nominal reserves without due regard to actual value of assets which are frequently used for purpose other than originally intended.", :short_text => :w
  end

  section "Budgeting" do
    q "What best describes the your budget planning process?", :pick => :one
    a "Budgetary control of all expenditures are based on flexible performance standards equitably established by operating levels.", :short_text => :p
    a "Organizational budget structure is rigid, with ratios of expense to sales based upon past performance, not on predetermined, flexible performance standards.", :short_text => :a
    a "No attempt is made to budget or forecast performance.", :short_text => :w

    q "What best describes your sales program?", :pick => :one
    a "The sales budget is driven by products, salesmen, customers and territories, based on market analysis.", :short_text => :p
    a "The sales budget is driven by products, salesmen, customers and territories, based on part performance only.", :short_text => :a
    a "The company has no sales budget and/or no quotas for salesmen.", :short_text => :w

    q "What best describes the company's pricing control policy?", :pick => :one
    a "Knowledge and control of the effect of all selling price is centralized, with changes driven by budgeted amount of total net profits.", :short_text => :p
    a "No centralized control of selling prices within limits of predetermined profit requirements.", :short_text => :a
    a "The company has no established pricing policy; cost estimates are ignored where considerable volume is involved; the effect of cutting prices to meet competition is not projected in terms of lost profits.", :short_text => :w

    q "What best describes your performance reporting policy?", :pick => :one
    a "Daily, weekly or monthly reports on performance of all departments is controlled through standard or budgeted performance metrics and/or variance from standard performance parameters.", :short_text => :p
    a "Divisional accounting reports are periodically exhibited to compare current with past periods but with no standards, no comparisons can be accomplished and no insights into the causes of variations can be gleaned.", :short_text => :a
    a "There is no standard performance reporting; policies vacillate due to incomplete comparative information and analysis.", :short_text => :w
  end
  
  section "Accounting" do
    q "How would you describe your accounting standards?", :pick => :one
    a "All procedures, records, forms and reports are designed with a view to producing all required information at the lowest level of detail.", :short_text => :p
    a "Company accounting is fairly comprehensive, accurate, prompt and well-managed, with some written procedures.", :short_text => :a
    a "Company bookkeeping is accurate, but generally 'old-fashioned' and incomplete.", :short_text => :w

    q "What best describes the state of your accounting information?", :pick => :one
    a "Accounting data is supplied promptly in a form best-adapted to its use by management.", :short_text => :p
    a "Accounting data is not adequate in comparison with most modern conceptions of control by standards.", :short_text => :a
    a "Accounting information is not highly-regarded as a tool of management.", :short_text => :w

    q "What best describes your company's accounting technology?", :pick => :one
    a "The company has modern accounting equipment used effectively in preparation of necessary information and reports.", :short_text => :p
    a "The company has an accounting software package but it is not adaptable to current operations.", :short_text => :a
    a "The company's accounting software and/or processes are antiquated, cumbersome and wasteful.", :short_text => :w
  end
  
  section "Costs" do
    q "What best describes your costing system?", :pick => :one
    a "The cost system has been designed to reflect all variances between standard and actual costs.", :short_text => :p
    a "Our cost accounting is fairly accurate but not organized well enough to provide standard cost information promptly.", :short_text => :a
    a "We have no standard costs and/or our job cost is inaccurate and uncontrolled.", :short_text => :w

    q "What best describes your stance towards cost information?", :pick => :one
    a "Variances from standard performances is currently supplied to management for corrective action, either regularly or as-needed.", :short_text => :p
    a "Records and reports not best-suited to control and cost expenses.", :short_text => :a
    a "Cost information is mostly estimated; profit and loss statements may be inaccurate.", :short_text => :w

    q "What best describes the state of your historical record-keeping?", :pick => :one
    a "Unnecessary accounting records are routinely eliminated and management control reports furnished as needed.", :short_text => :p
    a "Many records, reports and statistics are maintained that are not useful as a tool of management.", :short_text => :a
    a "Some records and reports are kept that have no practical advantage.", :short_text => :w

    q "What best describes your stance towards production records?", :pick => :one
    a "All control records and costs are integrated with standard costs.", :short_text => :p
    a "Records are unrelated to control, and therefore are of little assistance.", :short_text => :a
    a "Production records required for suitable cost control are not maintained.", :short_text => :w

    q "What best describes your estimating policy?", :pick => :one
    a "All estimates for product pricing are based on standard costs; guesswork is eliminated and any loss of volume or profit is indicated.", :short_text => :p
    a "Estimates are not checked against actual cost.", :short_text => :a
    a "Estimates are determined by past performance and/or competition.", :short_text => :w

    q "Which best describes your profit & loss calculation?", :pick => :one
    a "The effect that sales mixture and product selling prices have on the total company profits picture at varying cooperating levels is known at all times.", :short_text => :p
    a "No knowledge of the effect on total business profits of individual product or order pricing is known.", :short_text => :a
    a "Profit and loss is estimated monthly, verified and adjusted annually to inventory; no profit or loss by product is known.", :short_text => :w

    q "What is the effect of sales volume on your organization?", :pick => :one
    a "The effect of additional volume on cost and profit is easily determined; break-even points can be determined and their value estimated.", :short_text => :p
    a "The effect of additional volume on cost and profit not easily determined; break-even points can not determined and their value can not be estimated.", :short_text => :a
    a "Additional volume is usually authorized to keep company busy without knowledge of effect on cost and profit; no knowledge of sales mixtures or break-even point.", :short_text => :w
  end
  
  section "Sales" do
    q "What best describes your sales planning policy?", :pick => :one
    a "The company has a sound sales program based on known customer needs, market research and analysis supported by good advertising and a strong sales program.", :short_text => :p
    a "Sales programming is based on past customer experience; market potential not known.", :short_text => :a
    a "Sales coverage is incomplete and/or knowledge of competition is limited.", :short_text => :w

    q "How are your sales budgets defined?", :pick => :one
    a "Sales budgets are classified by products, customers, salesmen and territories.", :short_text => :p
    a "Sales totals are estimated but not budgeted by products, customers and territories.", :short_text => :a
    a "The company does not have a sales budget.", :short_text => :w

    q "How are your prices determined?", :pick => :one
    a "Sound pricing is based on standard costs giving effect to all cost factors.", :short_text => :p
    a "Price structure is rigid; accurate product costs are not used in setting sales prices and/or competition partially governs pricing.", :short_text => :a
    a "Selling prices are based on competition or what market costs will bear; cost information is not generally used in setting prices.", :short_text => :w

    q "What is your sales analysis policy?", :pick => :one
    a "Profit or loss is determined by salesmen, territories, products and customers.", :short_text => :p
    a "No attempt is made to analyze gross and net profit by salesmen, territories, products and customers.", :short_text => :a
    a "We do not routinely perform sales analysis.", :short_text => :w

    q "How do you determine your sales focus?", :pick => :one
    a "Selective selling efforts are directed toward maximum profit.", :short_text => :p
    a "Selling effort is not directed toward best profit possibilities.", :short_text => :a
    a "No selective selling program.", :short_text => :w

    q "How are your sales forces trained?", :pick => :one
    a "Our trained sales force is intelligently directed and compensated.", :short_text => :p
    a "Our salesmen are closely supervised but our training program is inadequate.", :short_text => :a
    a "Our sales force is neither well-trained nor supervised and/or our compensation is not comparable to competitors.", :short_text => :w

    q "Which best describes your sales records policy?", :pick => :one
    a "All sales records are maintained currently.", :short_text => :p
    a "Sales records are not always maintained on a current basis.", :short_text => :a
    a "No sales records beyond orders and sales billed are maintained.", :short_text => :w
  end
  
  section "Technology" do
    q "What best describes your technology requirements?", :pick => :one
    a "Management and staff understands how to establish requirements and/or select computer systems.", :short_text => :p
    a "Ownership relies only on staff to establish requirements and/or select computer systems.", :short_text => :a
    a "The company has no internal knowledge on how to establish requirements and/or select computer systems.", :short_text => :w

    q "What best describes the state of your technology infrastructure hardware?", :pick => :one
    a "Our hardware is state-of-the-art and/or is expandable and upgradeable as the business grows.", :short_text => :p
    a "Our hardware meets our current needs but is costly to expand or upgrade.", :short_text => :a
    a "Our hardware does not meet the computerization standards of our industry and/or our competitors.", :short_text => :w

    q "What best describes the state of your technology infrastructure software?", :pick => :one
    a "The software we use is state-of-the-art and/or allows enhancements as the business grows.", :short_text => :p
    a "The software we use meets our current needs but is costly to enhance or replace.", :short_text => :a
    a "The software we use does not meet our current business needs and/or is not maintainable.", :short_text => :w

    q "What best describes the company's management information systems?", :pick => :one
    a "All management information systems are computerized to simplify decision-making.", :short_text => :p
    a "The company's management information systems meet the business's current needs but are not expandable.", :short_text => :a
    a "The company relies primarily on manual information processes.", :short_text => :w

    q "Which best describes the organization's online presence?", :pick => :one
    a "The organization has a superior website that provides a complete story about the company and encourages customer feedback and is referenced on all business material.", :short_text => :p
    a "The organization's website exists, but lacks easy access for customers and does not provide adequate information about the company or its products and/or services.", :short_text => :a
    a "The organization does not have a website or an understanding of the implications.", :short_text => :w
  end
  
  section "Manufacturing" do
    q "What best describes you research and development planning?", :pick => :one
    a "We continuously research improvements of our products, equipment and methods of manufacturing, and for the development of new products and markets.", :short_text => :p
    a "We research improvements of our new or existing products only on an as-needed basis.", :short_text => :a
    a "We do not regularly research and/or our product design and engineering procedures are inadequate.", :short_text => :w

    q "What best describes your research and development organization?", :pick => :one
    a "Efforts are thoroughly planned and highly organized under expert supervision with qualified personnel.", :short_text => :p
    a "Research and development activities not well organized.", :short_text => :a
    a "No regular personnel are qualified to conduct research and development.", :short_text => :w

    q "Which of the following best describes your research and development team's interaction?", :pick => :one
    a "The team cooperates closely with merchandising and sales, manufacturing, methods and tool engineering, to ensure market acceptance, proper manufacturing facilities and a competitive production cost.", :short_text => :p
    a "The company has a program for product research, design and engineering, but these activities are not carried out in cooperation with other divisions of the business.", :short_text => :a
    a "The need for research and product engineering is ignored.", :short_text => :w

    q "What best describes your purchasing policy?", :pick => :one
    a "The purchasing of all materials goes through competitive bids in accordance with specifications.", :short_text => :p
    a "The purchasing function is well-handled, and although it may lack complete coordination with engineering and production controls, and is fairly well expedited.", :short_text => :a
    a "The purchasing function is not completely centralized and/or poorly coordinated with engineering, production control or other departments or is poorly expedited.", :short_text => :w

    q "What best describes the company's plant engineering situation?", :pick => :one
    a "The company location is determined by studies of material and labor supply and market location; facilities are arranged in accordance with production methods and processes; maintenance and replacement of equipment and facilities is well-controlled.", :short_text => :p
    a "The company is not located as a result of economic study; machinery and equipment layout is not well correlated to material flow; maintenance and replacement of equipment is loosely controlled.", :short_text => :a
    a "The company location is determined by available building space; machinery, location and layout are arranged with little regard to economical material flow or handling; no facility replacement program is in place and control of maintenance is poor.", :short_text => :w

    q "Which of the following best describes your production operations?", :pick => :one
    a "Production is completely planned and scheduled in accordance with sales requirements and manufacturing facilities.", :short_text => :p
    a "Production is planned as to principal items; scheduling of material and labor needs is made by department heads.", :short_text => :a
    a "No central production control and/or scheduling; production is often dictated by the need to keep busy, resulting in unbalanced and/or excess inventories.", :short_text => :w

    q "What best describes your quality control process?", :pick => :one
    a "Quality control is segregated as a separate function; efficient inspection program is in-place, tailored to each product and used to aid to sales and manufacturing.", :short_text => :p
    a "Quality control is not centralized; inspections are performed as a manufacturing necessity only, except when quality complaints are made by customers.", :short_text => :a
    a "No separate quality control function exists except when complaints force extra precautionary measures; inspections are carried-on independently by department heads.", :short_text => :w

    q "What tool engineering processes are in place?", :pick => :one
    a "The head of methods and process engineering is capable of developing, improving, standardizing and simplifying the manufacturing process to reduce costs in cooperation with the factory and engineering departments.", :short_text => :p
    a "Tools are well constructed but not designed to produce lowest manufacturing cost; tool maintenance and inventory control is fair.", :short_text => :a
    a "Tool engineering is not well correlated with manufacturing processing to produce low product costs; tool maintenance and inventory control is poor.", :short_text => :w

    q "What best describes the organizations engineering methods?", :pick => :one
    a "The organization's process engineering and head of methods is capable of standardizing, developing, simplifying and improving manufacturing process to reduce costs in cooperation with the factory and engineering departments.", :short_text => :p
    a "The organization has a separate methods and standards department that operates in cooperation with manufacturing; tool and general engineering departments are not maintained.", :short_text => :a
    a "Engineering methods are worked out by various department heads; improvements are slow, records are generally poor and control of manufacturing processing is minimal.", :short_text => :w

    q "What best describes your production procedures?", :pick => :one
    a "High-quality, low-cost production for all products is obtained by use of modern machinery, good company layout and material flow, with high labor efficiency attained with incentive pay and able supervision.", :short_text => :p
    a "Machinery is up to date, but material flow needs improvement; costs are not the lowest in the field, with loose incentive rates for labor; improved supervision needed.", :short_text => :a
    a "Manufacturing is not well-planned or supervised; machinery is old, materials flow is poor, product quality is fair; no incentives for labor; supervision is indifferent.", :short_text => :w

    q "Which of the following best describes your warehousing program?", :pick => :one
    a "Our warehousing program is designed to meet customer delivery requirements as determined by a study of competitive market conditions.", :short_text => :p
    a "Our warehousing is designed to service large, established sales centers only, not necessarily determined by analysis of competitive market conditions.", :short_text => :a
    a "Our warehousing is maintained at the manufacturing location with no consideration given to competitive sales and market conditions.", :short_text => :w
  end
end