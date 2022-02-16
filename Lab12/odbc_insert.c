#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>
#include <stdlib.h>

#define PARAM_ARRAY_SIZE 2
#define IMIE_L 50
#define NAZWISKO_L 50

int odbc_insert()
{
	SQLHENV     hEnv = NULL;
	SQLHDBC     hDbc = NULL;
	SQLHSTMT    hStmt = NULL;
	char*      pwszConnStr;
	char       wszInput[512];
	SQLRETURN	ret;
	//char		tmpbuf[256];
	int row = 0;
	SQLINTEGER  person_id[] = { 5,2 };
	SQLUSMALLINT ParamStatusArray[PARAM_ARRAY_SIZE];
	SQLLEN       ParamsProcessed = 0;
	SQLLEN imie_l=0, nazwisko_l=0;
	SQLCHAR imie[IMIE_L];
	SQLCHAR nazwisko[NAZWISKO_L];

	// Allocate an environment
	if (SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &hEnv) == SQL_ERROR){
		fprintf(stderr, "Unable to allocate an environment handle\n");
		exit(-1);
	}

	// Register this as an application that expects 3.x behavior,
	// Allocate a connection
	RETCODE rc = SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, (SQLPOINTER)SQL_OV_ODBC3, 0);
	if (rc != SQL_SUCCESS)
	{
		//HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
		fprintf(stderr, "Error");
	}
	if (rc == SQL_ERROR)
	{
		fprintf(stderr, "Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,	(SQLPOINTER)SQL_OV_ODBC3,0)\n");
		exit(-1);
	}

	rc = SQLAllocHandle(SQL_HANDLE_DBC, hEnv, &hDbc);
	if (rc != SQL_SUCCESS)
	{
		//HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
		fprintf(stderr, "Error");
	}
	if (rc == SQL_ERROR)
	{
		fprintf(stderr, "Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,	(SQLPOINTER)SQL_OV_ODBC3,0)\n");
		goto Exit;
	}

	pwszConnStr = "BD1LAB01";

	rc = SQLConnect(hDbc, pwszConnStr, SQL_NTS, NULL, 0, NULL, 0);

	fprintf(stderr, "Connected!\n");

	rc = SQLAllocHandle(SQL_HANDLE_STMT, hDbc, &hStmt);

	strcpy(wszInput, "INSERT into lab04.uczestnik(id_uczestnik, imie, nazwisko) values (?,?,?) ;");

	RETCODE     RetCode;
	SQLSMALLINT sNumResults;

	// Execute the query
	// Prepare Statement
	//RetCode = SQLPrepare(hStmt, wszInput, SQL_NTS);

	//RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAMSET_SIZE, (SQLPOINTER)PARAM_ARRAY_SIZE, 0);
	//RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAM_STATUS_PTR, ParamStatusArray, PARAM_ARRAY_SIZE);
	//RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAMS_PROCESSED_PTR, &ParamsProcessed, 0);

	// Bind array values of parameter 1
	RetCode = SQLBindParameter(hStmt, 1, SQL_PARAM_INPUT, SQL_C_LONG, SQL_INTEGER, 0, 0, person_id, 0, NULL);
	
	RetCode = SQLBindParameter(hStmt, 2, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_CHAR, IMIE_L, 0, imie, IMIE_L, &imie_l);
	
	RetCode = SQLBindParameter(hStmt, 3, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_CHAR, NAZWISKO_L, 0, nazwisko, NAZWISKO_L, &nazwisko_l);
	
	stpcpy(imie, "Janina"); imie_l=strlen(imie);
	strcpy(nazwisko, "Cygan"); nazwisko_l=strlen(nazwisko);

	RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);
	//RetCode = SQLExecute(hStmt);
	//RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);


	// Retrieve number of columns
	rc = SQLNumResultCols(hStmt, &sNumResults);
	//wprintf(L"Number of Result Columns %i\n", sNumResults);

	
	switch (RetCode)
	{
	case SQL_SUCCESS_WITH_INFO:
	{
		printf("%hd\n", RetCode);
	}
	case SQL_SUCCESS:
	{
		rc = SQLNumResultCols(hStmt, &sNumResults);

		if (sNumResults > 0)
		{
			//DisplayResults(hStmt, sNumResults);
			while (SQL_SUCCEEDED(ret = SQLFetch(hStmt))) {
				SQLUSMALLINT i;
				printf("Row %d\n", row++);
				// Loop through the columns */
				for (i = 1; i <= sNumResults; i++) {
					SQLLEN indicator;
					char buf[512];
					// retrieve column data as a string
					ret = SQLGetData(hStmt, i, SQL_C_CHAR,	buf, sizeof(buf), &indicator);
					if (SQL_SUCCEEDED(ret)) {
						/* Handle null columns */
						if (indicator == SQL_NULL_DATA) strcpy(buf, "NULL");
						printf("  Column %u : %ws\n", i, buf);
					}
				}
			}
		}
		else
		{
			SQLLEN cRowCount;

			rc = SQLRowCount(hStmt, &cRowCount);
			if (cRowCount >= 0)
			{
				printf("%Id %s affected\n", cRowCount, cRowCount == 1 ? "row" : "rows");
			}
		}
		break;
	}

	case SQL_ERROR:
	{
		//HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
		fprintf(stderr, "Error");
		break;
	}

	default:
		fprintf(stderr, "Unexpected return code %hd!\n", RetCode);

	}
	rc = SQLFreeStmt(hStmt, SQL_CLOSE);

Exit:

	if (hStmt)
	{
		SQLFreeHandle(SQL_HANDLE_STMT, hStmt);
	}

	if (hDbc)
	{
		SQLDisconnect(hDbc);
		SQLFreeHandle(SQL_HANDLE_DBC, hDbc);
	}

	if (hEnv)
	{
		SQLFreeHandle(SQL_HANDLE_ENV, hEnv);
	}

	printf("\nUFF - pozamiatane\n");

	return 0;
}

int main(){
	odbc_insert();
	return 0;
}
