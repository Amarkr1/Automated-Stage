// Sample C control program from Yenista Optics' CT400
// version 1.4.0
// tested succesfully with Borland C++ XE7 and Netbeans 8.0 along with C compiler MinGW4.7
// ---------------------------------------------------------------------------

#include <tchar.h>
#include <stdio.h>
#include <stdlib.h>

#include "CT400_lib.h"

int main(void)
{
	/************* Variables declaration ********************** */

	uint64_t uiHandle;  					// CT400 handle
	char tcError[1024];						// Error message
	int32_t iError = 0;                     // Error/warning in init
	int32_t iErrorMsg = 0; 			    	// Error code
	double Pout, P1, P2, P3, P4, Vext;		// Power and voltage values in output and detectors 1 to 5
	int32_t iNbofInputs;					// Number of CT400 inputs
	int32_t iNbofDetectors;					// Number of CT400 detectors
	int32_t iCT400Type;                     // CT400 Option
	int32_t iDataPoints;               	    // Number of points acquired by the CT400
	int32_t iDiscardPoints;            	    // Number of points to discard (in case of triggered measurements)
	int32_t iPointsNumber;					// Exchange variable
	int32_t iPointsNumberResampled;                         // Number of resampled points
	int32_t iLinesDetected;                                 // Number of spectral lines detected
	double *dDetector5Sync = 0, *dDetector5Resampled = 0;	// Data arrays
	double *dWavelengthSync = 0, *dWavelengthResampled = 0;
	double *dLinesValues = 0;

	uint32_t i;

	/************* Init DLL for connection to the CT400 ********************/

	// Initializing CT400_lib.dll library to connect to the CT400
	uiHandle = CT400_Init(&iError);

	if (uiHandle > 0)
	{
	// ************* CT400 outlook *****************************************/

        // Number of available inputs
		iNbofInputs = CT400_GetNbInputs(uiHandle);
		printf("Number of Inputs: %d\n", iNbofInputs);

		// Number of available detectors
		iNbofDetectors = CT400_GetNbDetectors(uiHandle);
		printf("Number of Detectors: %d\n", iNbofDetectors);

		// CT400 option (0: SMF, 1: PM13, 2: PM13)
		iCT400Type = CT400_GetCT400Type(uiHandle);

		if (iCT400Type == 0)
		{
			printf("CT400 Option: (%d) SMF, 1240-1680 nm\n", iCT400Type);
		}
		else if(iCT400Type == 1)
		{
			printf("CT400 Option: (%d) PMF13, 1260-1360 nm\n", iCT400Type);
		}
		else if (iCT400Type == 2)
		 {
			printf("CT400 Option: (%d) PMF15, 1440-1640 nm\n", iCT400Type);
		 }
		 else
		 {
			printf("CT400 Option: (%d), not known\n", iCT400Type);
         }


        // Checks if connection with the CT400 is still established
		if (CT400_CheckConnected(uiHandle) == 1)
		{
		// ************* Sweep Configuration *******************************/

		// Configure Laser inputs.
		CT400_SetLaser(uiHandle, LI_1, ENABLE, 10, LS_TunicsT100s_HP, 1240.0, 1380.0, 50);
		CT400_SetLaser(uiHandle, LI_2, ENABLE, 11, LS_TunicsT100s_HP, 1350.0, 1510.0, 50);

		// Configure sweep range and laser power
		// Sweep from 1350 to 1360 nm at 5 mW
		CT400_SetScan(uiHandle, 5.0, 1350.0, 1360.0);

		// Set sampling resolution
		// Set to 100pm
		CT400_SetSamplingResolution(uiHandle, 100);

		// Configuring detector status
		// Only detector 1 and Ext are used
		CT400_SetDetectorArray(uiHandle, DISABLE, DISABLE, DISABLE, ENABLE);

		// Configuring the BNC analog port
		// Voltage at BNC port can be read
		CT400_SetBNC(uiHandle, DISABLE, 0, 0, 1);

		//*************** CT400 sweep ***********************************//

		// Launch scan
		CT400_ScanStart(uiHandle);

		// Wait for scan ending
		iErrorMsg = CT400_ScanWaitEnd(uiHandle, tcError);

		// Verification of errors or warnings during scan
		if (iErrorMsg == 0 || iErrorMsg == 999)
			{
			 if (iErrorMsg == 999) // Warning
				 printf("Warning: %s\n", tcError);

			printf("Everything went OK!\n");

		//*************** Data collecting *******************************//

			// Number of measured points is requested
			CT400_GetNbDataPoints(uiHandle, &iDataPoints, &iDiscardPoints);
			iPointsNumber = iDataPoints;
			printf("Number of measured points: %d\n", iDataPoints);
			printf("Number of points to discard if triggered measurements: %d\n", iDiscardPoints);
			dWavelengthSync = (double *) calloc(iPointsNumber, sizeof(double));
			dDetector5Sync = (double *) calloc(iPointsNumber, sizeof(double));

			// Number of resampled points is requested
			iPointsNumberResampled = CT400_GetNbDataPointsResampled(uiHandle);
			printf("Number of resampled lambda points: %d\n", iPointsNumberResampled);
			dWavelengthResampled = (double *) calloc(iPointsNumberResampled, sizeof(double));
			dDetector5Resampled = (double *) calloc(iPointsNumberResampled, sizeof(double));

			// Synced Wavelengths is saved in an array
			CT400_ScanGetWavelengthSyncArray(uiHandle, dWavelengthSync, iPointsNumber);

			// Synced IL on the detector 1 is saved in an array
			CT400_ScanGetDetectorArray(uiHandle, DE_5, dDetector5Sync, iPointsNumber);

			for (i = 0; i < iPointsNumber ; i++)
				printf("%.4f %.2f\n", dWavelengthSync[i],dDetector5Sync[i]);

			// Resampled Wavelengths is saved in an array
			CT400_ScanGetWavelengthResampledArray(uiHandle, dWavelengthResampled, iPointsNumberResampled);

			// Resampled IL on the detector 1 is saved in an array
			CT400_ScanGetDetectorResampledArray(uiHandle, DE_5, dDetector5Resampled, iPointsNumberResampled);

			for (i = 0; i < iPointsNumberResampled ; i++)
				 printf("%.3f %.2f\n", dWavelengthResampled[i],dDetector5Resampled[i]);

			// Resampled Wavelengths are saved in a file
			CT400_ScanSaveWavelengthResampledFile(uiHandle, "Lambda_Resampled.txt");

			// Synced Wavelengths are saved in a file
			CT400_ScanSaveWavelengthSyncFile(uiHandle, "Lambda_Sync.txt");

			// Synced IL on detector 1 is saved in a file
			CT400_ScanSaveDetectorFile(uiHandle, DE_5, "Output_Detector5_Sync.txt");

			// Resampled IL on detector 1 is saved in a file
			CT400_ScanSaveDetectorResampledFile(uiHandle, DE_5, "Output_Detector5_Resampled.txt");

			// Synced output power and IL are saved in a file
			CT400_ScanSavePowerSyncFile(uiHandle, "Output_Sync.txt");

			// Resampled output power and IL are saved in a file
			CT400_ScanSavePowerResampledFile(uiHandle, "Output_Resampled.txt");

			// Display spectral lines detected in case a light source is connected in
			// input 2 and 4
			iLinesDetected = CT400_GetNbLinesDetected(uiHandle);
			dLinesValues = (double *) calloc(iLinesDetected, sizeof(double));
			CT400_ScanGetLinesDetectionArray(uiHandle, dLinesValues, iLinesDetected);
			for(i = 0; i < iLinesDetected; i++)
			  {
				printf("Spectral line #%d : %.4f\n", i+1, dLinesValues[i]);
			   }

			// Power on all detectors is read and displayed
			CT400_ReadPowerDetectors(uiHandle, &Pout, &P1, &P2, &P3, &P4, &Vext);
			printf("Power on detectors:\n");
			printf("Pout = %.2f\n", Pout);
			printf("P1 = %.2f\n", P1);
			printf("P2 = %.2f\n", P2);
			printf("P3 = %.2f\n", P3);
			printf("P4 = %.2f\n", P4);
			printf("Vext = %.4f\n", Vext);

			// Laser in port 1 is disabled
			CT400_CmdLaser(uiHandle, LI_2, DISABLE, 1350, 1.0);
			}
			else {
				  printf("Error %d: %s\n", iErrorMsg, tcError); // Notification if errors
			}
		}
		else
			printf("Communication can not be established with CT400 \n");

		   // Memory deallocation
		   if (dDetector5Sync != 0) free(dDetector5Sync);
		   if (dDetector5Resampled != 0) free(dDetector5Resampled);
		   if (dWavelengthSync != 0) free(dWavelengthSync);
		   if (dWavelengthResampled != 0) free(dWavelengthResampled);
		   if (dLinesValues != 0) free(dLinesValues);
        }
        else {
			  printf("Initialization of the CT400_lib.dll was not possible. Verify CT400 is on!");
        }
	   // Closing connection with CT400
	   CT400_Close(uiHandle);
	   return 0;

}
